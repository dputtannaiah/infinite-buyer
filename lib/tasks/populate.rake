namespace 'populate' do
  desc 'populate categories'
  task 'category' => :environment do
    Category.all.map { |category| category.touch :deleted_at }
    #PRODUCTS

    Appliances = {
        'Air Conditioners & Accessories' => {},
        'Air Purifiers' => {},
        'Appliance Services' => {},
        'Appliance Warranties' => {},
        'Beer Keg Refrigerators' => {},
        'Beverage Refrigerators' => {},
        'Compact Refrigerators' => {},
        'Cooktops' => {},
        'Dehumidifiers' => {},
        'Dishwashers' => {},
        'Household Fans' => {},
        'Food Disposers' => {},
        'Freezers' => {},
        'Humidifiers' => {},
        'Ice Makers' => {},
        'Irons, Steamers & Accessories' => {},
        'Microwave Ovens' => {},
        'Parts & Accessories' => {},
        'Range Hoods' => {},
        'Ranges' => {},
        'Refrigerators' => {},
        'Small Appliances' => {},
        'Space Heaters' => {},
        'Trash Compactors' => {},
        'Vacuums & Floor Care' => {},
        'Wall Ovens' => {},
        'Warming Drawers' => {},
        'Washers & Dryers' => {},
        'Wine Cellars' => {},
        'Ceiling Fans & Accessories' => {}

    }

    Arts_Crafts_And_Sewing = {
        'Art Supplies' => {},
        'Beading & Jewelry-Making' => {},
        'Cases & Transport' => {},
        'Craft Supplies' => {},
        'Fabric' => {},
        'Fabric Care' => {},
        'Fabric Painting & Dyeing' => {},
        'Furniture & Accessories' => {},
        'Knitting & Crochet' => {},
        'Needlework' => {},
        'Organization & Storage' => {},
        'Photography' => {},
        'Printmaking' => {},
        'Safety & Cleaning' => {},
        'Scrapbooking' => {},
        'Sewing' => {},
        'Thread' => {},
        'Yarn' => {},
        'Party Decorations & Supplies' => {},
    }

    Automotive = {
        'Car Care' => {},
        'Exterior Accessories' => {},
        'Interior Accessories' => {},
        'Car Electronics & Accessories' => {},
        'Motorcycle & ATV' => {},
        'Oils & Fluids' => {},
        'Paint, Body & Trim' => {},
        'Performance Parts & Accessories' => {},
        'Replacement Parts' => {},
        'RV Parts & Accessories' => {},
        'Tools & Equipment' => {},
        'Tires & Wheels' => {},
        'Automotive Enthusiast Merchandise' => {}

    }
    Baby = {'Apparel&Accessories' => {},
            'Baby & Toddler Toys' => {},
            'Baby Stationery' => {},
            'Bathing & Skin Care' => {},
            'Car Seats & Accessories' => {},
            'Diapering' => {},
            'Feeding' => {},
            'Gear' => {},
            'Gifts' => {},
            'Health & Baby Care' => {},
            'Nursery' => {},
            'Potty Training' => {},
            'Pregnancy & Maternity' => {},
            'Safety' => {},
            'Shoes' => {},
            'Strollers' => {}
    }

    Beauty = {
        'Bath & Body' => {},
        'Fragrance' => {},
        'Hair Care' => {},
        'Makeup' => {},
        'Skin Care' => {},
        'Tools & Accessories' => {}
    }

    Books = {
        'Arts & Photography' => {},
        'Biographies&Memoirs' => {},
        'Business & Investing' => {},
        'Calendars' => {},
        'Childrens Books' => {},
        'Christian Books & Bibles' => {},
        'Comics & Graphic Novels' => {},
        'Computers & Technology' => {},
        'Cookbooks, Food & Wine' => {},
        'Crafts, Hobbies & Home' => {},
        'Education & Reference' => {},
        'Gay & Lesbian' => {},
        'Health, Fitness & Dieting' => {},
        'History' => {},
        'Humor & Entertainment' => {},
        'Law' => {},
        'Literature & Fiction' => {},
        'Medical Books' => {},
        'Mystery, Thriller & Suspense' => {},
        'Parenting & Relationships' => {},
        'Politics & Social Sciences' => {},
        'Professional & Technical' => {},
        'Religion & Spirituality' => {},
        'Romance' => {},
        'Science & Math' => {},
        'Science Fiction & Fantasy' => {},
        'Self-Help' => {},
        'Sports & Outdoors' => {},
        'Teens' => {},
        'Travel' => {}
    }
    Shoes={'Athletic & Outdoor' => {},
           'Boots' => {},
           'Fashion Sneakers' => {},
           'Loafers & Slip-Ons' => {},
           'Mules & Clogs' => {},
           'Oxfords' => {},
           'Sandals' => {},
           'Slippers' => {},
           'Work & Safety' => {},
    }

    Women = {'Tops & Tees' => {},
             'Sweaters ' => {},
             'Fashion Hoodies & Sweatshirts' => {},
             'Active ' => {},
             'Dresses' => {},
             'Jumpsuits & Rompers' => {},
             'Jeans' => {},
             'Pants & Capris' => {},
             'Leggings' => {},
             'Shorts' => {},
             'Skirts' => {},
             'Blazers & Jackets' => {},
             'Clothing Sets' => {},
             'Suits' => {},
             'Outerwear & Coats' => {},
             'Socks & Hosiery' => {},
             'Sleep & Lounge' => {},
             'Intimates' => {},
             'Swim' => {},
             'Accessories' => {},
             'Maternity' => {},
             'Shoes' => Shoes
    }

    Shoes={
        'Athletic & Outdoor' => {},
        'Boots' => {},
        'Fashion Sneakers' => {},
        'Loafers & Slip-Ons' => {},
        'Oxfords' => {},
        'Sandals' => {},
        'Slippers' => {},
        'Sneakers' => {},
        'Work & Safety' => {}
    }

    Men={
        'Tops & Tees' => {},
        'Shirts' => {},
        'Fashion Hoodies & Sweatshirts' => {},
        'Active' => {},
        'Sweaters' => {},
        'Suits & Sport Coats' => {},
        'Jeans' => {},
        'Pants' => {},
        'Shorts' => {},
        'Outerwear & Coats' => {},
        'Socks' => {},
        'Underwear' => {},
        'Sleep & Lounge' => {},
        'Swim' => {},
        'Accessories' => {},
        'Shoes' => Shoes

    }
    Shoes={
        'Athletic & Outdoor' => {},
        'Boots' => {},
        'Mules & Clogs' => {},
        'Crib Shoes' => {},
        'First Walkers' => {},
        'Flats' => {},
        'Loafers' => {},
        'Oxfords' => {},
        'Sandals' => {},
        'Slippers' => {},
        'Sneakers' => {},
        'Uniform & School Shoes' => {}
    }

    Girls = {
        'Dresses' => {},
        'Fashion Clothing Sets' => {},
        'Tops & Tees' => {},
        'Sweaters' => {},
        'Fashion Hoodies & Sweatshirts' => {},
        'Active' => {},
        'Jeans' => {},
        'Overalls' => {},
        'Jumpsuits & Rompers' => {},
        'Pants & Capris' => {},
        'Leggings' => {},
        'Shorts' => {},
        'Skirts, Scooters & Skorts' => {},
        'Outerwear & Coats' => {},
        'Sleepwear & Robes' => {},
        'Socks & Tights' => {},
        'Underwear' => {},
        'Swim' => {},
        'Accessories' => {},
        'Shoes' => Shoes

    }

    Shoes={
        'Athletic & Outdoor' => {},
        'Boots' => {},
        'Mules & Clogs' => {},
        'Crib Shoes' => {},
        'First Walkers' => {},
        'Loafers' => {},
        'Oxfords' => {},
        'Sandals' => {},
        'Slippers' => {},
        'Sneakers' => {},
        'Uniform & School Shoes' => {}
    }

    Boys ={
        'Suits & Sport Coats' => {},
        'Fashion Clothing Sets' => {},
        'Tops & Tees' => {},
        'Button-Down & Dress Shirts' => {},
        'Sweaters' => {},
        'Fashion Hoodies & Sweatshirts' => {},
        'Active' => {},
        'Jeans' => {},
        'Overalls' => {},
        'Pants' => {},
        'Shorts' => {},
        'Outerwear & Coats' => {},
        'Sleepwear & Robes' => {},
        'Socks' => {},
        'Underwear' => {},
        'Swim' => {},
        'Accessories' => {},
        'Shoes' => Shoes

    }

    Baby2 = {
        'Baby Girls' => {},
        'Baby Boys' => {},
        'Unisex' => {}
    }

    Accessories_Women = {'Fashion Scarves' => {},
                         'Wraps&Pashminas' => {},
                         'Handbags' => {},
                         'Wallets' => {},
                         'Belts' => {},
                         'Sunglasses' => {},
                         'Bridal Veils' => {},
                         'Cold Weather' => {}
    }

    Accessories_Men = {
        'Hats & Caps' => {},
        'Fashion Scarves' => {},
        'Neckties' => {},
        'Belts' => {},
        'Cufflinks' => {},
        'Wallets' => {},
        'Money Clips' => {},
        'Sunglasses' => {},
        'Cold Weather' => {}
    }

    Accessories_Girls ={
        'Hats & Caps' => {},
        'Belts' => {},
        'Sunglasses' => {},
        'Fashion Scarves' => {},
        'Cold Weather' => {}
    }

    Accessories_Boys = {
        'Hats & Caps' => {},
        'Belts' => {},
        'Sunglasses' => {},
        'Cold Weather' => {}
    }

    Accessories_Baby_Girls ={
        'Hats & Caps' => {},
        'Bibs & Burp Cloths' => {},
        'Receiving Blankets' => {},
        'Hair Accessories' => {},
        'Gloves & Mittens' => {}
    }

    Accessories_Baby_Boys ={
        'Hats & Caps' => {},
        'Bibs & Burp Cloths' => {},
        'Receiving Blankets' => {},
        'Gloves & Mittens' => {}
    }

    Accessories_Shoe_Care = {
        'Electric Shoe Polishers' => {},
        'Ice & Snow Grips' => {},
        'Polishes & Dyes' => {},
        'Shoe & Boot Trees' => {},
        'Shoe Bags' => {},
        'Shoe Brushes' => {},
        'Shoe Care Kits & Sets' => {},
        'Shoe Decoration Charms' => {},
        'Shoe Dryers' => {},
        'Shoe Horns & Boot Jacks' => {},
        'Shoe Inserts & Insoles' => {},
        'Shoe Measuring Devices' => {},
        'Shoelaces' => {}

    }

    Novelty_SpecialUseClothing={
        'Novelty' => {},
        'Costumes & Accessories' => {},
        'Exotic Apparel' => {},
        'Band T-Shirts & Music Fan Apparel' => {},
        'Movie & TV Fan Apparel' => {},
        'Sports Clothing' => {},
        'Work Wear & Uniforms' => {},
        'World Apparel' => {}

    }

    Luggage_Bags = {
        'Backpacks' => {},
        'Briefcases' => {},
        'Diaper Bags' => {},
        'Fashion Waist Packs' => {},
        'Gym Bags' => {},
        'Laptop Bags & Cases' => {},
        'Luggage' => {},
        'Messenger Bags' => {},
        'Travel Accessories' => {},
        'Umbrellas' => {}
    }

    Watches ={
        'Wrist Watches' => {},
        'Pocket Watches' => {},
        'Watch Bands' => {},
        'Accessories' => {},
        'Novelty Watches' => {}
    }

    Clothing_And_Accessories= {'Women' => Women,
                               'Men' => Men,
                               'Girls' => Girls,
                               'Boys' => Boys,
                               'Baby' => Baby2,
                               'Accessories-Women' => Accessories_Women,
                               'Accessories-Men' => Accessories_Men,
                               'Accessories-Girls' => Accessories_Girls,
                               'Accessories-Boys' => Accessories_Boys,
                               'Accessories-Baby Girls' => Accessories_Baby_Girls,
                               'Accessories-Baby Boys' => Accessories_Baby_Boys,
                               'Accessories-Shoe Care' => Accessories_Shoe_Care,
                               'Novelty & Special Use Clothing' => Novelty_SpecialUseClothing,
                               'Luggage & Bags' => Luggage_Bags,
                               'Watches' => Watches
    }

    Collectibles = {
        'Entertainment' => {},
        'Sports' => {}
    }


    Audio_Video_Accessories_368377 = {
        '3DGlasses' => {},
        'Antennas' => {},
        'Cables & Interconnects' => {},
        'Cleaning & Repair' => {},
        'Crossover Parts' => {},
        'Distribution' => {},
        'Headphone Accessories' => {},
        'Headphones' => {},
        'Home Audio Crossovers & Parts' => {},
        'Media Storage & Organization' => {},
        'Remote Controls' => {},
        'Satellite TV Equipment' => {},
        'Speaker Accessories' => {},
        'Speaker Parts & Components' => {},
        'Speaker Repair' => {},
        'Turntable Cartridges & Needles' => {},
        'TV Accessories' => {},
        'VCR Rewinders' => {},
        'Video Converters' => {},
        'Connectors & Adapters' => {},
        'RF Modulators' => {},
        'Projector Accessories' => {}

    }

    Camera_Photo_Accessories_788919 = {
        'Batteries & Chargers' => {},
        'Binocular Accessories' => {},
        'Binocular, Camera & Camcorder Straps' => {},
        'Blank Media' => {},
        'Cables & Cords' => {},
        'Camcorder Accessories' => {},
        'Case & Bag Accessories' => {},
        'Cases & Bags' => {},
        'Cleaners' => {},
        'Darkroom Supplies' => {},
        'Digital Camera Accessories' => {},
        'Digital Photo Viewers' => {},
        'Digital Picture Frame Screen Protector Foils' => {},
        'Film' => {},
        'Filter Accessories' => {},
        'Filters' => {},
        'Flash Accessories' => {},
        'Lens Accessories' => {},
        'Light Boxes & Loupes' => {},
        'Light Meters & Accessories' => {},
        'Lighting' => {},
        'Microscope Accessories' => {},
        'Photo Studio' => {},
        'Professional Video Accessories' => {},
        'Rain Covers' => {},
        'Remote Controls' => {},
        'Sandbags' => {},
        'Telescope Accessories' => {},
        'Tripod & Monopod Accessories' => {},
        'Viewfinders' => {}

    }

    Cell_Phone_Accessories_1780211 = {'Accessory Kits' => {},
                                      'Audio Adapters' => {},
                                      'Batteries' => {},
                                      'CarAccessories' => {},
                                      'Cases & Covers' => {},
                                      'Chargers' => {},
                                      'Data Cables' => {},
                                      'Headsets' => {},
                                      'MicroSD Cards' => {},
                                      'Mounts' => {},
                                      'Phone Charms' => {},
                                      'Replacement Parts' => {},
                                      'Screen Protectors' => {},
                                      'Signal Boosters' => {},
                                      'Styli' => {},
                                      'Cell Phone Warranties' => {}

    }

    Computer_Accessories_4320630 = {
        'Blank Media' => {},
        'Cable Security Devices' => {},
        'Cables & Interconnects' => {},
        'Cleaning & Repair' => {},
        'Computer Cable Adapters' => {},
        'Computer Speakers' => {},
        'Hard Drive Bags' => {},
        'Hard Drive Cases' => {},
        'Hard Drive Enclosures' => {},
        'Headsets & Microphones' => {},
        'Keyboard & Mice Accessories' => {},
        'Keyboards, Mice & Input Devices' => {},
        'Laptop & Netbook Computer Accessories' => {},
        'Memory Card Adapters' => {},
        'Memory Card Readers' => {},
        'Memory Cards' => {},
        'Monitor Accessories' => {},
        'Printer Accessories' => {},
        'Printer Ink & Toner' => {},
        'Scanner Accessories' => {},
        'Surge Protectors' => {},
        'Touch Screen Tablet Accessories' => {},
        'Uninterrupted Power Supply (UPS)' => {},
        'USB Gadgets' => {},
        'Video Projector Accessories' => {}

    }

    Accessories_Supplies = {'Audio & Video Accessories' => Audio_Video_Accessories_368377,
                            'Camera & Photo Accessories' => Camera_Photo_Accessories_788919,
                            "Cell Phone Accessories" => Cell_Phone_Accessories_1780211,
                            "Computer Accessories" => Computer_Accessories_4320630,
                            'GPS System Accessories' => {},
                            'Home Audio Accessories' => {},
                            'Office Electronics Accessories' => {},
                            'Portable Audio & Video Accessories' => {},
                            'Batteries, Chargers & Accessories' => {},
                            'Telephone Accessories' => {},
                            'Television Accessories' => {},
                            'Blank Media' => {},
                            'Cables' => {},
                            'Mounts' => {},
                            'Installation Services' => {},
                            'Microphones' => {},
                            'Power Protection' => {}

    }

    Camera_Photo ={
        'Digital Cameras' => {},
        'Camcorders' => {},
        'Accessories' => {},
        ' Binoculars, Telescopes & Optics' => {},
        'Film Cameras' => {},
        'Flashes' => {},
        'Lenses' => {},
        'Handheld Digital Photo Viewers' => {},
        'Printers & Scanners' => {},
        'Projectors' => {},
        'Surveillance Cameras' => {},
        'Tripods & Monopods' => {},
        'Underwater Photography' => {}

    }

    CellPhones_Accessories = {
        'Phones with Plans' => {},
        'Unlocked Phones' => {},
        'Mobile Broadband' => {},
        'No-Contract Phones & Devices' => {},
        'Accessories' => {},
        'Tablets' => {},
        'Sim Cards' => {}

    }

    Computers_Accessories = {
        'Desktops' => {},
        'Laptops' => {},
        'Netbooks' => {},
        'Tablets' => {},
        'Servers' => {},
        'External Data Storage' => {},
        'Networking Products' => {},
        'Printers' => {},
        'Scanners' => {},
        'Monitors' => {},
        'Video Projectors' => {},
        'PDAs, Handhelds & Accessories' => {},
        'Game Hardware' => {},
        'Webcams' => {},
        'Computer Components' => {},
        'Computer Accessories' => {},
        'External Components' => {},
        'Warranties & Services' => {}

    }
    eBookReaders_Accessories = {
        'eBook Readers' => {},
        'Bundles' => {},
        'Covers' => {},
        'Power Adapters' => {},
        'Power Cables' => {},
        'Reading Lights' => {},
        'Screen Protectors' => {},
        'Skins' => {},
        'Sleeves' => {},
        'Stands' => {}
    }
    Television_Video = {
        'Analog-to-Digital (DTV) Converters' => {},
        'AV Receivers & Amplifiers' => {},
        'Blu-ray Players & Recorders' => {},
        'Digital Media Devices' => {},
        'DVD Players & Recorders' => {},
        'DVD-VCR Combos' => {},
        'HD DVD Players' => {},
        'Home Theater Systems' => {},
        'Projection Screens' => {},
        'Projectors' => {},
        'Satellite Television' => {},
        'Television Accessories' => {},
        'Televisions' => {},
        'TV-DVD Combinations' => {},
        'VCRs' => {},
        'Video Glasses' => {}

    }

    Electronics = {
        'Accessories & Supplies' => Accessories_Supplies,
        'Camera & Photo' => Camera_Photo,
        'Cell Phones & Accessories' => CellPhones_Accessories,
        'Computers & Accessories' => Computers_Accessories,
        'eBook Readers & Accessories' => eBookReaders_Accessories,
        'Television & Video' => Television_Video,
        'Electronics Warranties' => {},
        'GPS & Navigation' => {},
        'Home Audio' => {},
        'Office Electronics' => {},
        'Portable Audio & Video' => {},
        'Security & Surveillance' => {},
        'Service & Replacement Plans' => {},
        'Car & Vehicle Electronics' => {}
    }

    Gift_Cards_Store = {
        'Amazon Gift Cards' => {},
        'Automotive & Industrial' => {},
        'Books, Movies & Music' => {},
        'Clothing, Shoes & Accessories' => {},
        'Department Stores' => {},
        'Electronics & Office' => {},
        'Grocery, Gourmet & Floral' => {},
        'Health & Beauty' => {},
        'Home & Decor' => {},
        'Home Improvement' => {},
        'Restaurants' => {},
        'Social Networking' => {},
        'Spa & Salon' => {},
        'Sports, Outdoors & Fitness' => {},
        'Toys, Kids & Baby' => {},
        'Travel & Leisure' => {}

    }

    Health_And_Personal_Care = {
        'Baby & Child Care' => {},
        'Diet & Nutrition' => {},
        'Health Care' => {},
        'Household Supplies' => {},
        'Medical Supplies & Equipment' => {},
        'Personal Care' => {},
        'Sexual Wellness' => {},
        'Stationery & Party Supplies' => {}

    }

    Home_And_Kitchen = {
        'Kids Home Store' => {},
        'Kitchen & Dining' => {},
        'Bedding' => {},
        'Furniture' => {},
        'Home Decor' => {},
        'Wall Decor' => {},
        'Seasonal Decor' => {},
        'Heating, Cooling & Air Quality' => {},
        'Irons & Steamers' => {},
        'Vacuums & Floor Care' => {},
        'Storage & Organization' => {},
        'Cleaning Supplies' => {}
    }

    Jewelry ={
        'Rings' => {},
        'Wedding & Engagement Rings' => {},
        'Necklaces & Pendants' => {},
        'Earrings' => {},
        'Bracelets & Bangles' => {},
        'Charms' => {},
        'Brooches & Pins' => {},
        'Anklets' => {},
        'Mens Jewelry' => {},
        'Childrens Jewelry' => {},
        'Religious Jewelry' => {},
        'Jewelry Sets' => {},
        'Loose Gemstones' => {},
        'Accessories' => {},
        'Novelty Jewelry' => {},

    }

    Movies_And_TV = {'Movies' => {},
                     'TV' => {},
    }

    Music = {
        'Alternative Rock' => {},
        'Blues' => {},
        'Broadway & Vocalists' => {},
        'Childrens Music' => {},
        'Christian' => {},
        'Classic Rock' => {},
        'Classical' => {},
        'Country' => {},
        'Dance & Electronic' => {},
        'Folk' => {},
        'Gospel' => {},
        'Hard Rock & Metal' => {},
        'Jazz' => {},
        'Latin Music' => {},
        'Miscellaneous' => {},
        'New Age' => {},
        'Pop' => {},
        'R&B' => {},
        'Rap & Hip-Hop' => {},
        'Rock' => {},
        'Soundtracks' => {},
        'World Music' => {},
        'Music Video & Concerts' => {}
    }

    Musical_Instruments = {
        'Guitars' => {},
        'Bass Guitars' => {},
        'Drums & Percussion' => {},
        'Keyboards' => {},
        'Band & Orchestra' => {},
        'Folk & World Instruments' => {},
        'Instrument Accessories' => {},
        'DJElectronic Music & Karaoke' => {},
        'Live Sound & Stage' => {},
        'Studio Recording Equipment' => {}

    }

    Office_Products = {
        'Office & School Supplies' => {},
        'Office Electronics' => {},
        'Office Furniture & Lighting' => {}

    }

    Patio_Lawn_And_Garden={
        'Backyard Birding & Wildlife' => {},
        'Farm & Ranch' => {},
        'Gardening' => {},
        'Generators & Portable Power' => {},
        'Grills & Outdoor Cooking' => {},
        'Mowers & Outdoor Power Tools' => {},
        'Outdoor Decor' => {},
        'Outdoor Heaters & Fire Pits' => {},
        'Outdoor Storage' => {},
        'Patio Furniture & Accessories' => {},
        'Pest Control' => {},
        'Pools Hot Tubs & Supplies' => {},
        'Snow Removal' => {}

    }

    Pet_Supplies ={
        'Birds' => {},
        'Cats' => {},
        'Dogs' => {},
        'Fish & Aquatic Pets' => {},
        'Horses' => {},
        'Insects' => {},
        'Reptiles & Amphibians' => {},
        'Small Animals' => {}

    }

    Software = {
        'Accounting & Finance' => {},
        'Business & Office' => {},
        'Childrens' => {},
        'Computer Security' => {},
        'Education & Reference' => {},
        'Games' => {},
        'Home & Hobbies' => {},
        'Home Publishing' => {},
        'Illustration & Design' => {},
        'Language & Travel' => {},
        'Networking' => {},
        'Operating Systems' => {},
        'Photo Editing' => {},
        'Programming & Web Development' => {},
        'Tax Preparation' => {},
        'Utilities' => {},
        'Video & Music' => {}

    }

    Sports_And_Outdoors = {
        'Action Sports' => {},
        'Bikes & Scooters' => {},
        'Boating & Water Sports' => {},
        'Equestrian Sports' => {},
        'Exercise & Fitness' => {},
        'Golf' => {},
        'Hunting & Fishing' => {},
        'Leisure Sports & Games' => {},
        'Outdoor Recreation' => {},
        'Paintball & Airsoft' => {},
        'Racquet Sports' => {},
        'Snow Sports' => {},
        'Team Sports' => {},
        'Other Sports' => {},
        'Accessories' => {},
        'Clothing' => {},
        'Fan Shop' => {}

    }

    Tools_And_Home_Improvement = {
        'Appliances' => {},
        'Building Supplies' => {},
        'Electrical' => {},
        'Hardware' => {},
        'Kitchen & Bath Fixtures' => {},
        'Lighting & Ceiling Fans' => {},
        'Painting Supplies & Wall Treatments' => {},
        'Power & Hand Tools' => {},
        'Rough Plumbing' => {},
        'Safety & Security' => {},
        'Storage & Home Organization' => {},
        'Heavy Equipment & Agricultural Supplies' => {}

    }

    Toys_And_Games = {
        'Action & Toy Figures' => {},
        'Arts & Crafts' => {},
        'Baby & Toddler Toys' => {},
        'Building Toys' => {},
        'Dolls & Girls Toys' => {},
        'Dress Up & Pretend Play' => {},
        'Electronics for Kids' => {},
        'Games' => {},
        'Grown-Up Toys' => {},
        'Hobbies' => {},
        'Kids Furniture & Decor' => {},
        'Learning & Education' => {},
        'Novelty & Gag Toys' => {},
        'Party Supplies' => {},
        'Puzzles' => {},
        'Sports & Outdoor Play' => {},
        'Stuffed Animals & Plush' => {},
        'Tricycles, Scooters & Wagons' => {},
        'Vehicles & Remote-Control' => {}

    }

    Video_Games = {
        'PlayStation 3' => {},
        'Xbox 360' => {},
        'Wii' => {},
        'Wii U' => {},
        'PC' => {},
        'Mac' => {},
        'Nintendo DS' => {},
        'Nintendo 3DS' => {},
        'PlayStation Vita' => {},
        'Sony PSP' => {},
        'More Systems' => {},
        'Digital Games' => {}
    }

    Products = {'Appliances' => Appliances,
                'Arts, Crafts & Sewing' => Arts_Crafts_And_Sewing,
                'Automotive' => Automotive,
                'Baby' => Baby,
                'Beauty' => Beauty,
                'Books' => Books,
                'Clothing & Accessories' => Clothing_And_Accessories,
                'Collectibles' => Collectibles,
                'Electronics' => Electronics,
                'Gift Cards Store' => Gift_Cards_Store,
                'Health & Personal Care' => Health_And_Personal_Care,
                'Home & Kitchen' => Home_And_Kitchen,
                'Jewelry' => Jewelry,
                'Movies & TV' => Movies_And_TV,
                'Music' => Music,
                'Musical Instruments' => Musical_Instruments,
                'Office Products' => Office_Products,
                'Patio, Lawn & Garden' => Patio_Lawn_And_Garden,
                'Pet Supplies' => Pet_Supplies,
                'Software' => Software,
                'Sports & Outdoors' => Sports_And_Outdoors,
                'Tools & Home Improvement' => Tools_And_Home_Improvement,
                'Toys & Games' => Toys_And_Games,
                'Video Games' => Video_Games
    }

    #SERVICES
    Professional = {'Art' => {},
                    'Childcare' => {},
                    'Financial' => {},
                    'Insurance' => {},
                    'Legal' => {},
                    'Marketing' => {},
                    'Media' => {},
                    'Medical' => {},
                    'Music' => {},
                    'Tutoring' => {}
    }

    Automotive = {'Alignment' => {},
                  'Body' => {},
                  'Brakes' => {},
                  'Oil Change' => {},
                  'Paint' => {}
    }

    Personal = {'Acupuncture' => {},
                'Beauty and Grooming' => {},
                'Chiropractic' => {},
                'Fitness' => {},
                'Hair Cuts' => {},
                'Massage' => {},
                'Pilates' => {},
                'Spa' => {},
                'Yoga' => {}
    }

    Home = {'Appliance Repairs' => {},
            'Carpet Cleaning' => {},
            'Computer Repairs' => {},
            'Duct Cleaning' => {},
            'Electrical Repairs' => {},
            'Gardening' => {},
            'Handyman Repairs' => {},
            'House Cleaning' => {},
            'Landscaping' => {},
            'Painting' => {},
            'Pet Services' => {},
            'Plumbing' => {}
    }

    Services = {
        'Automotive' => Automotive,
        'Home' => Home,
        'Personal' => Personal,
        'Professional' => Professional

    }

    CATEGORIES = {'Products' => Products,
                  'Services' => Services
    }


    class Categories
      def self.create categories = CATEGORIES, parent=nil
        categories.each_pair do |key, value|
          c = Category.new
          c.parent = parent if parent
          category = Category.with_deleted.find_or_create_by_name_and_ancestry key, c.ancestry
          category.update_attribute :deleted_at, nil
          create(value, category) unless value.empty?
        end
      end
    end

    Categories.create
    Category.with_deleted.find_by_name("Services").subtree.update_all("category_type = #{Category::CategoryType::SERVICE}")
    Category.with_deleted.find_by_name("Products").subtree.update_all("category_type = #{Category::CategoryType::PRODUCT}")

  end


end # End of Name space