class HomePage < BasePage
  set_url '/'

  #HEADER
  element :sign_up_link, 'a[href="/users/sign_up"]'
  element :login_link, 'a[href="/users/sign_in"]'

  element :user_email, '.header-user-email-js'
  element :settings, '.dropdown:last-child:hover li:first-child a'
  element :logout, '.dropdown:last-child:hover li:last-child a'

  #MAIN PAGE
  element :filters_title, '#filters h1'
  element :catalog_title, 'h1.general-title-margin'

  element :no_books_title, '#no_books h2'

  element :view_more_button, '#view_more'

  elements :books, '.general-thumb-wrap'
end
