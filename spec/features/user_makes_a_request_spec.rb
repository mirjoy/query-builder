require 'rails_helper'

RSpec.describe "a user enters a full query", type: :feature do
  it "can use all of the functionality" do
    visit root_path
    fill_in("article[title]")
    find('#entity-type').find(:xpath, 'person').select_option

    click_link_or_button("Submit")
    expect(page).to have_content(articles.first.title)
    expect(page).to have_content(articles.first.excerpt)
    expect(page).to have_content(articles.first.body_enrichment)
    expect(articles.count).to eq(15)

    click_link_or_button(article.title)
    expect(page).to have_content(article.first.title)
  end
end
