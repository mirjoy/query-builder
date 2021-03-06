require 'rails_helper'

RSpec.describe "a user enters a full query", type: :feature do
  xit "can use all of the functionality" do
    visit root_path
    fill_in("home[news_query]", with: "Martin Luther King")
    within('#home_entity') do
      find('Person').select_option
    end

    click_link_or_button("Submit")
    expect(page).to have_content(articles.first.title)
    expect(page).to have_content(articles.first.excerpt)
    expect(page).to have_content(articles.first.body_enrichment)
    expect(articles.count).to eq(15)

    click_link_or_button(article.title)
    expect(page).to have_content(article.first.title)
  end
end
