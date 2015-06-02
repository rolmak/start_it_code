FactoryGirl.define do
  factory :user do
    first_name "Vārds"
    last_name "Uzvārds"
    email "user@mail.com"
    password "parole123"
    phone "12345678"
    school "Skola"
    school_class "12"
    birthday "2001-01-01"
  end

  factory :second_user, :class => User do
    first_name "Vārdss"
    last_name "Uzvārdss"
    email "second_user@mail.com"
    password "parole123456"
    phone "87654321"
    school "Skola 1"
    school_class "1"
    birthday "2002-02-02"
  end

  trait :admin do
    is_admin true
  end

  trait :teacher do
    is_teacher true
    teacher_candidate false
  end
end

# == Schema Information
#
# Table name: users
#
#  birthday               :date
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  email                  :string(255)      default(""), indexed
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)      not null
#  forem_admin            :boolean          default(FALSE)
#  forem_auto_subscribe   :boolean          default(FALSE)
#  forem_state            :string(255)      default("pending_review")
#  id                     :integer          not null, primary key
#  is_admin               :boolean          default(FALSE)
#  is_teacher             :boolean          default(FALSE)
#  last_name              :string(255)      not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  phone                  :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)      indexed
#  school                 :string(255)      default(""), not null
#  school_class           :string(255)      default(""), not null
#  sign_in_count          :integer          default(0)
#  teacher_candidate      :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
