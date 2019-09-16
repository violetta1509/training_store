module AuthHash
  def authhash(email)
    OmniAuth::AuthHash.new(
      'uid' => '1488',
      'provider' => 'facebook',
      'info' => {
        'email' => email,
        'name' => 'JonnieHallman',
        'image' => 'http://graph.facebook.com/v2.10/2647900795285004/picture'
      }
    )
  end
end
