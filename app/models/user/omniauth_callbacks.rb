class User < ActiveRecord::Base
  module OmniauthCallbacks
    def find_or_create_for_twitter response
      user = User.find_by_twitter_id(response['uid'])
      user = User.new(:twitter_id => response['uid'],
                      :password => Devise.friendly_token[0, 20]) unless user
      user.skip_confirmation!
      user.save(:validate => false) && user
    end

    def find_or_create_for_facebook response
      user = User.find_by_facebook_id(response['uid'])
      user = User.new(:facebook_id => response['uid'],
                      :password => Devise.friendly_token[0, 20],
                      :email => response['extra']['raw_info']['email']) unless user
      user.skip_confirmation!
      user.save(:validate => false) && user
    end
  end
end
