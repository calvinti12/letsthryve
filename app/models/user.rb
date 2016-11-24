class User < ApplicationRecord
  
end

# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  fb_messenger_id   :string
#  fb_profile_id     :string
#  ignore            :boolean          default(FALSE)
#  last_message_sent :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  fb_messenger_id_idx  (fb_messenger_id)
#  fb_profile_id_idx    (fb_profile_id)
#
