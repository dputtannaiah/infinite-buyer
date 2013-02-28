/**
 * Clickinc.com Tracker Script - June 16, 2012
 */
/*Replace XXXXX with your Merchant Id */
var merchantId = "70632";
var overWriteCookie = false;  // change this to true if you want to over write the cookies of referred details with the last visit.

/********Please Do Not change Anything Below this ***************/
var varb = new getVariables();
/* SALES/ORDER BLOCK */
function xmlPost() {
    var img = new Image();
    img.src = varb.xmlOrderURL + "?xmlOrder=" + getXML();
}

function getXML() {
    // local variable declarations
    var XML = "";
    var XMLProducts = "";
    var XMLErrors = "";
    var AffiliateId = 0;
    var ReferralURL = "";
    var OrderId = "0";
    var UserId = "";
    var TransactionStatus = "0";
    var Country = "-";
    var Discount = 0;
    var SubTotal = 0;
	var Promotion = "0";
	var SubCampaign = "0";
	var AffiliateReferral = "";
    var Products = new Array();
    var tmpStr = "";
    var Errors = new Array();
    // Sanitation
   if (GetCookie(varb.asm) !== null) {
        AffiliateId = Sanitize(GetCookie(varb.asm));
    }
    if (GetCookie(varb.asmReferral) !== null) {
        ReferralURL = GetCookie(varb.asmReferral).replace(/&/g, " and ");
    }
	if (GetCookie(varb.prom) !== null) {
        Promotion = Sanitize(GetCookie(varb.prom));
    }	
	if (GetCookie(varb.affreferral) !== null) {
        AffiliateReferral = GetCookie(varb.affreferral);
    }
	if (GetCookie(varb.sub) !== null) {
        SubCampaign = GetCookie(varb.sub);
    }
	var _ipq_ipq = document.getElementById(varb.ipq);
	try {
        if (_ipq_ipq != null) {
            var token = _ipq_ipq.value.split(varb.colan);
            if (token != null && token.length !== 0) {
                // OrderId
                if (token[0] !== null && token[0].length > 0) {
                    OrderId = Sanitize(token[0]);
                } else {
                    // set default value
                    OrderId = Sanitize("err-" + Math.random());
                    tmpStr = Sanitize("Error found in OrderId! ipq values: " + _ipq_ipq.value + "" + OrderId);
                    Errors.push(tmpStr);
                }
                // UserId
                if (token[2] !== null && token[2].length > 0) {
                    UserId = Sanitize(token[2]);
                } else {
                    tmpStr = Sanitize("Error found in UserId! ipq values: " + _ipq_ipq.value);
                    Errors.push(tmpStr);
                }
                // TransactionStatus
                if (token[4] !== null && token[4].length > 0) {
                    TransactionStatus = Sanitize(token[4]);
                } else {
                    tmpStr = Sanitize("Error found in TransactionStatus! ipq values: " + _ipq_ipq.value);
                    Errors.push(tmpStr);
                }
                // Country
                if (token[3] !== null && token[3].length > 0) {
                    Country = Sanitize(token[3]);
                } else {
                    tmpStr = Sanitize("Error found in Country! ipq values: " + _ipq_ipq.value);
                    Errors.push(tmpStr);
                }
                // Discount
                if (token[1] !== null && token[1].length > 0) {
                    Discount = Sanitize(token[1]);
                } else {
                    tmpStr = "Error found in Discount! ipq values: " + Sanitize(_ipq_ipq.value);
                    Errors.push(tmpStr);
                }
            } else {  
                ///// if (token.length ==0) 
                tmpStr = "Error found in ipq! ipq values: " + Sanitize(_ipq_ipq.value);
                Errors.push(tmpStr);
            }
        } else {
			OrderId = Sanitize("err-" + Math.random());
            tmpStr = Sanitize("Could not locate " + varb.ipq);
            Errors.push(tmpStr);
        }
    }
    catch (err) {
        tmpStr = "General exception catched in Sanitation! ";
        tmpStr += "Exception: " + Sanitize(err.description) + ". ";
        tmpStr += "ipq values: " + Sanitize(_ipq_ipq.value) + ". ";
        tmpStr = Sanitize(tmpStr);
        Errors.push(tmpStr);
    }
	
    // Product Sanitation
    var ErrorFound = false;
    var rawProductId = document.getElementsByName(varb.productId);
    var rawPrice = document.getElementsByName(varb.price);
    var rawQuantity = document.getElementsByName(varb.quantity);
    try {
        // Logic flag. If set to true, will raise exception and dump all products array information for logging/debugging purpose
        // Make sure all productid/price/quantity arrays are having any element
        if (rawProductId.length == 0 || rawProductId.length == 0 || rawQuantity.length == 0) {
            Errors.push("null value found in product sanitation");
            ErrorFound = true;
        }
        // Make sure all productid/price/quantity arrays have the same number of elements 
        if (rawProductId.length !== rawPrice.length || rawProductId.length !== rawQuantity.length) {
            Errors.push("different array length found in product sanitation");
            ErrorFound = true;
        } else {
        // Clean the Product information from the raw arrays into a bi-dimensional array using this structure [index][productid, quantity, price]
            for (var Counter = 0; Counter < rawProductId.length; Counter++) {
                var ProductId = "";
                var Quantity = 0;
                var Price = 0;
                // ProductId
                if (rawProductId[Counter] != null && rawProductId[Counter].value.length > 0) {
                    ProductId = Sanitize(rawProductId[Counter].value);
                } else {
                    Errors.push("Error found while sanitizing ProductId");
                    ErrorFound = true;
                }   
                // Quantity
                if (rawQuantity[Counter] != null && rawQuantity[Counter].value.length > 0) {
                    Quantity = Sanitize(rawQuantity[Counter].value);
                } else {
                    Errors.push("Error found while sanitizing Quantity");
                    ErrorFound = true;
                }   
                // Price
                if (rawPrice[Counter] != null && rawPrice[Counter].value.length > 0) {
                    Price = Sanitize(rawPrice[Counter].value);
                } else {
                    Errors.push("Error found while sanitizing Price");
                    ErrorFound = true;
                }
                // Add product to bidimensional array [index][productid, quantity, price]
                Products[Counter] = new Array(ProductId, Quantity, Price);
            }
            // trigger product debug logic
            if (ErrorFound == true) {
                throw (exception);
            }
        }
    }
    catch (err) {        
        // #####################################################
        // # LOOP THOURGH ALL RAW ARRAYS AND WRITE DOWN VALUES #
        // #####################################################
        tmpStr = "General exception catched in Product Sanitation! Exception: " + Sanitize(err.description) + ". Dumping product information for debugging...";
        Errors.push(tmpStr);
        // dumping rawProductId
        tmpStr = "rawProductId : ";
        for (var Counter = 0; Counter < rawProductId.length; Counter++) {
            tmpStr += "[" + Counter + "] -> " + Sanitize(rawProductId[Counter].value) + "  |  ";
        }
        Errors.push(tmpStr);
        // dumping rawQuantity
        tmpStr = "rawQuantity : ";
        for (var Counter = 0; Counter < rawQuantity.length; Counter++) {
            tmpStr += "[" + Counter + "] -> " + Sanitize(rawQuantity[Counter].value) + "  |  ";
        }
        Errors.push(tmpStr);
        // dumping rawPrice
        tmpStr = "rawPrice : ";
        for (var Counter = 0; Counter < rawPrice.length; Counter++) {
            tmpStr += "[" + Counter + "] -> " + Sanitize(rawPrice[Counter].value) + "  |  ";
        }
        tmpStr = Sanitize(tmpStr);
        Errors.push(tmpStr);
    }
    // Calculate Subtotal  
    try {
        for (var Counter = 0; Counter < Products.length; Counter++) {
            SubTotal += Products[Counter][1] * Products[Counter][2];
        }
    }
    catch (err) {
        tmpStr = "There was an exception calculating SubTotal value. Exception: " + Sanitize(err.description);
        Errors.push(tmpStr);
    }  
    // Generate XML schema
    XML = "<?xml version=\"1.0\" ?>" + "<order>" + "<id>" + OrderId + "</id>" + "<merchant>" + merchantId + "</merchant>" + "<affiliateid>" + AffiliateId + "</affiliateid>" + "<domain>" + ReferralURL + "</domain>" + "<subtotal>" + SubTotal + "</subtotal>" + "<discount>" + Discount + "</discount>" + "<customer>" + UserId + "</customer>" + "<country>" + Country + "</country>" + "<status>" + TransactionStatus + "</status>"+ "<promotion>" + Promotion + "</promotion> " + "<affReferral>" + AffiliateReferral + "</affReferral>" + "<subCampaign>" + SubCampaign + "</subCampaign>";
	var _recurring_recurring = document.getElementById(varb.recurring);
    try {
        if (_recurring_recurring != null) {
			XML = XML + "<recurring>" + Sanitize(_recurring_recurring.value) + "</recurring>";
		}
	}  catch (err) {
	}
	var _coupon_coupon = document.getElementById(varb.coupon);
    try {
        if (_coupon_coupon != null) {
			XML = XML + "<coupon>" + Sanitize(_coupon_coupon.value) + "</coupon>";
		}
	}  catch (err) {
	}
    // Generate XML for Products
    XMLProducts = "<products>";
    // Add product to XML from bidimensional array [index][productid, quantity, price,category[optional]]
    for (var Counter = 0; Counter < Products.length; Counter++) {
        XMLProducts += "<product>" + "<id>" + Products[Counter][0] + "</id>" + "<price>" + Products[Counter][2] + "</price>" + "<quantity>" + Products[Counter][1] + "</quantity>"; 
        var _category_category = document.getElementById(varb.category);
        try {
            if (_coupon_coupon != null) {
    			XML = XML + "<category>" + Sanitize(_category_category.value) + "</category>";
    		}
    	}  catch (err) {
    	}
    	XMLProducts +=  "</product>";
    }
    XMLProducts += "</products>";
    // Generate XML for Errors
    if (Errors.length > 0) {
        XMLErrors = "<errors>";
        for (var Counter = 0; Counter < Errors.length; Counter++) {
            XMLErrors += "<error>" + Errors[Counter] + "</error>";
        }
        XMLErrors += "</errors>";
    } else { 
		XMLErrors = "<errors />";
    }
   // Finalize XML schema
    XML = XML + XMLProducts + XMLErrors;
    XML += "</order>";
    return XML;
}
function Sanitize(value) {
    if (value == null) {
        value = "";
    }
    value = value.replace(/^\s+|\s+$/g, "");
    value = value.replace(/'/g, "");
    value = value.replace(/"/g, "");
    value = value.replace(/&/g, "");
    value = value.replace(/\$/g, "");
    return value;
}
/* CAPTURING CLICKS BLOCK */
var affSoft_kbId = 0;
var affSoft_queryString = window.location.search.substring(1);
var affSoft_imgdata = "";
var affSoft_subdata = "0";
var affSoft_promodata = "";
var affSoft_overwrite = 0;
var affSoft_refdata = document.referrer;
var affSoft_daysToLive = cookieVal;
var affSoft_asmValue = "0";
var affSoft_asmReferralValue = "";
var affSoft_affReferralValue = "";
var multiDomain = false;
if (affSoft_queryString.length > 0) {
    var pairs = affSoft_queryString.split(varb.ampsend);
    for (var i = 0; i < pairs.length; i++) {
        var pairs2 = pairs[i].split(varb.equals);
        switch (pairs2[0].toLowerCase()) {
          case varb.affid:
            affSoft_kbId = pairs2[1];
            break;
          case varb.id:
            if (affSoft_kbId == 0) {
                affSoft_kbId = pairs2[1];
            }
            break;
          case varb.img:
            affSoft_imgdata = pairs2[1];
            break;
          case varb.sub:
            affSoft_subdata = pairs2[1];
            break;
		  case varb.prom:
            affSoft_promodata = pairs2[1];
            break;
		  case varb.affreferral:
            affSoft_affReferralValue = pairs2[1];
            break;
        }
    }
}

// checking for the click Id and same Click or not 
if (aff_IsNewVisitor() == true) { //aff_IsAffiliateClick()==true && 
    InitializeTimer();
}
var secs;
var timerID = null;
var timerRunning = false;
var delay = 1000;
function InitializeTimer() {
    // Set the length of the timer, in seconds
    secs = 4;
    StopTheClock();
    StartTheTimer();
}
function StopTheClock() {
    if (timerRunning) {
        clearTimeout(timerID);
    }
    timerRunning = false;
}
function StartTheTimer() {
    if (secs == 0) {
        StopTheClock();
        // Here's where you put something useful that's
        // supposed to happen after the allotted time.
        // For example, you could display a message:
        postFunction();
    } else {
       // self.status = secs;
        secs = secs - 1;
        timerRunning = true;
        timerID = self.setTimeout("StartTheTimer()", delay);
    }
}
function postFunction() {
	aff_Post();
	SetCookie(varb.asm, affSoft_kbId, affSoft_daysToLive);
    SetCookie(varb.affreferral, affSoft_affReferralValue, affSoft_daysToLive);
    SetCookie(varb.asmReferral, affSoft_refdata, affSoft_daysToLive);
	SetCookie(varb.sub, affSoft_subdata, affSoft_daysToLive);
	SetCookie(varb.prom, affSoft_promodata, affSoft_daysToLive);
}
function aff_IsNewVisitor() { 
	var urlPage = window.location.href;
	if (!checkForVaue(GetCookie(varb.asm))&&!checkForVaue(GetCookie(varb.asmReferral))&&(checkForVaue(affSoft_kbId)||checkForVaue(affSoft_refdata))){
		return true;
	} else {
		if(checkForVaue(affSoft_kbId)||checkForVaue(affSoft_refdata)){
			if(checkForVaue(GetCookie(varb.asm))||checkForVaue(GetCookie(varb.asmReferral))){
				if(overWriteCookie && ((GetCookie(varb.asm)!=affSoft_kbId && checkForVaue(affSoft_kbId)) || (checkForVaue(affSoft_refdata)&&GetCookie(varb.asmReferral)!=affSoft_refdata)&& GetDomainName(affSoft_refdata)!= GetDomainName(urlPage))){
					return true;
				}else{
					return false;
				}
			}
		}else{
			return false;
		}
	}
}

function GetDomainName(domainValue ) {
	if(checkForVaue(domainValue )){
		domainValue = domainValue.replace(".", "_");
		if (domainValue.indexOf("//")!=-1)
			domainValue = domainValue.substring(domainValue.indexOf("//") + 2, domainValue.length);
		if (domainValue.indexOf("www") !=-1)
			domainValue = domainValue.substring(domainValue.indexOf("_") + 1, domainValue.length);
		if (domainValue.indexOf("/") !=-1)
			domainValue = domainValue.substring(0, domainValue.indexOf("/"));
		if (domainValue.indexOf("?") !=-1)
			domainValue = domainValue.substring(0, domainValue.indexOf("?"));
		domainValue = domainValue.replace("_", ".");
		return domainValue;
	}else{
		return "";
	}
}

function checkForVaue(checkValue){
  if (checkValue == null) {
        checkValue = "";
    }
    if(checkValue == null || checkValue == '0' || checkValue ==''){
    return false;
  }else{
    return true;
  }

}
		
//Posting Click
function aff_Post() {
    var img = new Image();
    var url = varb.clicksURL + varb.ampId + affSoft_kbId;
    if (affSoft_imgdata != "") {
        url += varb.ampImgId + affSoft_imgdata + varb.ampBanner;
    } else {
        url += varb.ampText;
    }
    if (affSoft_subdata != "") {
        url += varb.ampSub + affSoft_subdata;
    }
    if (affSoft_refdata != "") {
        url += varb.ampReferrer + escape(affSoft_refdata);
    }
    img.src = url;
}
function getCookieVal(offset) {
    var endstr = document.cookie.indexOf(varb.semiColon, offset);
    if (endstr == -1) {
        endstr = document.cookie.length;
    }
    return unescape(document.cookie.substring(offset, endstr));
}
function GetCookie(name) {
    var arg = name + varb.equals;
    var alen = arg.length;
    var clen = document.cookie.length;
    var i = 0;
    while (i < clen) {
        var j = i + alen;
        if (document.cookie.substring(i, j) == arg) {
            return getCookieVal(j);
        }
        i = document.cookie.indexOf(" ", i) + 1;
        if (i == 0) {
            break;
        }
    }
    return null;
}
function WriteCookie(name, value, expires) {
    var argv = SetCookie.arguments;
    var argc = SetCookie.arguments.length;
	//inserted by Andrew Herron to fix cross-sub-domain cookie compatibility, 
    if (multiDomain) {
        rootDomain = document.domain;
    } else {
        domain = document.domain;
        dparts = domain.split(varb.dot);
        if (dparts.length == 3) {
            rootDomain = dparts[1] + varb.dot + dparts[2];
        } else {
            rootDomain = domain;
        }
    }
    var secure = (argc > 5) ? argv[5] : false;
    var cookie = name + varb.equals + escape(value) + ((expires == null) ? "" : (varb.expires + expires.toGMTString())) + ((varb.slash == null) ? "" : (varb.path + varb.slash)) + ((rootDomain == null) ? "" : (varb.semiDomain + rootDomain)) + ((secure == true) ? varb.semiSecure : "");
    document.cookie = cookie;
}
function DeleteCookie(name) {
    var exp = new Date();
    exp.setTime(exp.getTime() - 1000000000);  // This cookie is history (changed -1 to make it previous time)
    var cval = GetCookie(name);
    document.cookie = name + varb.equals + cval + varb.expires + exp.toGMTString();
}
function SetCookie(name, value, expiredays) {
    var expdate = new Date();
    expdate.setTime(expdate.getTime() + (24 * 60 * 60 * 1000 * expiredays));
    WriteCookie(name, value, expdate);
}
/* submit action */
function submitAction(form) {
    form.referedBy.value = GetCookie(varb.asm);
	form.referedUrl.value = GetCookie(varb.asmReferral);
    form.submit();
}
/* VARIABLES DECLARATION BLOCK */
function getVariables() {
    /* SALES VARIABLES START */
    /* PLEASE DO NOT CHANGE ANYTHING IN THIS BLOCK */
    this.xmlOrderURL = "https://ca.clickinc.com/sales/servlet/SalesXML";
    this.productId = "_productId_productId";
    this.price = "_price_price";
    this.quantity = "_quantity_quantity";
	this.recurring = "_recurring_recurring";
	this.category = "_category_category";
	this.coupon = "_coupon_coupon";
    this.ipq = "_ipq_ipq";
    this.hash = "#";
    this.colan = ":";
    /* SALES VARIABLES END */
    /* CLICKS VARIABLES START */
    /* PLEASE DO NOT CHANGE ANYTHING IN THIS BLOCK */
    this.clicksURL = "http://ca.clickinc.com/clicks/servlet/Click?merchant=" + merchantId;
    this.ampsend = "&";
    this.equals = "=";
    this.id = "id";
    this.affid = "affid";
    this.img = "img";
	this.prom = "promotion";
	this.sub = "sub";
    this.asm = "asm";
	this.affreferral = "affreferral";
    this.asmReferral = "asmReferral";
	this.ampId = "&affId=";
    this.ampImgId = "&img=";
    this.ampSub = "&sub=";
    this.ampReferrer = "&referrer=";
    this.semiColon = ";";
    this.slash = "/";
    this.dot = ".";
    this.expires = "; expires=";
    this.path = "; path=";
    this.semiDomain = "; domain=";
    this.semiSecure = "; secure";
    this.ampBanner = "&type=banner";
    this.ampText = "&type=text";
    /* CLICKS VARIABLES END */
}