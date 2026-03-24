require 'spec_helper'

RSpec.describe 'hugo site', type: :feature do
  describe 'default layout structure' do
    before { visit '/' }

    it 'has the correct meta charset' do
      expect(page).to have_css('meta[charset="utf-8"]', visible: false)
    end

    it 'has a viewport meta tag' do
      expect(page).to have_css('meta[name="viewport"][content="width=device-width, initial-scale=1.0"]', visible: false)
    end

    it 'has a description meta tag' do
      expect(page).to have_css('meta[name="description"][content="Personal portfolio and blog of Sascha Faun Winter"]', visible: false)
    end

    it 'has an author meta tag' do
      expect(page).to have_css('meta[name="author"][content="Sascha Faun Winter"]', visible: false)
    end

    it 'includes the application stylesheet' do
      expect(page).to have_css('link[href*="application"][media="all"]', visible: false)
    end

    it 'includes Google Fonts' do
      expect(page).to have_css('link[href*="fonts.googleapis.com"][href*="Roboto"]', visible: false)
    end

    it 'includes the favicon' do
      expect(page).to have_css('link[href="/assets/ico/favicon.ico"]', visible: false)
    end

    it 'includes apple touch icons' do
      expect(page).to have_css('link[rel="apple-touch-icon-precomposed"][sizes="144x144"]', visible: false)
      expect(page).to have_css('link[rel="apple-touch-icon-precomposed"][sizes="114x114"]', visible: false)
      expect(page).to have_css('link[rel="apple-touch-icon-precomposed"][sizes="72x72"]', visible: false)
    end

    it 'includes jQuery' do
      expect(page).to have_css('script[src*="jquery"]', visible: false)
    end

    it 'includes the application javascript' do
      expect(page).to have_css('script[src*="application"]', visible: false)
    end
  end

  describe 'navigation header' do
    before { visit '/' }

    it 'has a fixed navbar' do
      expect(page).to have_css('header.navbar.navbar-fixed-top.navbar-inverse')
    end

    it 'has a Home link' do
      within('header.navbar') do
        expect(page).to have_link('Home', href: '/')
      end
    end

    it 'has a Resume link' do
      within('header.navbar') do
        expect(page).to have_link('Resume', href: '/resume/')
      end
    end

    it 'has a Contact link' do
      within('header.navbar') do
        expect(page).to have_link('Contact', href: '/contact/')
      end
    end

    it 'has exactly three navigation items' do
      within('header.navbar nav ul.nav') do
        expect(page).to have_css('li', count: 3)
      end
    end
  end

  describe 'homepage /' do
    before { visit '/' }

    it 'has the site name as the page title' do
      expect(page).to have_title('Sascha Faun Winter')
    end

    it 'has the page masthead with name' do
      within('.page-masthead') do
        expect(page).to have_css('h1', text: 'Sascha Faun Winter')
      end
    end

    it 'has the subtitle in masthead' do
      within('.page-masthead') do
        expect(page).to have_css('h4', text: 'Experienced Web Engineer located in San Francisco')
      end
    end

    it 'has a bio section' do
      expect(page).to have_css('.bio')
    end

    it 'has the Goals section' do
      expect(page).to have_content('Goals')
      expect(page).to have_content('high-autonomy, high-trust environment')
    end

    it 'has the Skills section' do
      expect(page).to have_content('Skills')
      expect(page).to have_content('experienced web application engineer')
    end

    it 'has the Highly Proficient section' do
      expect(page).to have_content('Highly Proficient')
      expect(page).to have_content('Golang')
      expect(page).to have_content('Ruby on Rails')
      expect(page).to have_content('JavaScript/TypeScript')
    end

    it 'links to the resume' do
      within(all('.bio').last) do
        expect(page).to have_link('resume', href: /resume/)
      end
    end

    it 'has the Elsewhere on the Web section' do
      expect(page).to have_css('nav.elsewhere')
      expect(page).to have_content('Elsewhere on the Web')
    end

    it 'has all external links' do
      within('nav.elsewhere') do
        expect(page).to have_link('Personal Photography', href: 'http://photos.faun.me')
        expect(page).to have_link('Twitter', href: 'https://twitter.com/faunzy')
        expect(page).to have_link('GitHub', href: 'https://github.com/faun')
        expect(page).to have_link('LinkedIn', href: 'http://www.linkedin.com/in/faunwinter')
        expect(page).to have_link('Flickr', href: 'http://flickr.com/faunzy')
        expect(page).to have_link('Instagram', href: 'http://instagram.com/faunzy')
      end
    end

    it 'has the sidebar with all blog posts' do
      within('aside nav.posts') do
        expect(page).to have_content('All Posts:')
        expect(page).to have_link('Cross-compiling Golang Applications for Synology 1513+')
        expect(page).to have_link('Decrypting PDFs as a Service')
        expect(page).to have_link('Installing RSpec, FactoryGirl and Capybara with Rails 3.2')
        expect(page).to have_link('Restoring Archived Files from Amazon Glacier')
      end
    end

    it 'does not show blog article title and attribution on homepage' do
      expect(page).not_to have_css('h1.page-title')
      expect(page).not_to have_css('aside.attribution')
    end
  end

  describe 'resume page /resume/' do
    before { visit '/resume/' }

    it 'has the site name as the page title' do
      expect(page).to have_title('Sascha Faun Winter')
    end

    it 'has the navigation header' do
      expect(page).to have_css('header.navbar')
    end

    it 'has the name heading' do
      expect(page).to have_content(/Sascha .Faun. Winter/)
    end

    it 'has the summary section' do
      expect(page).to have_content('Summary')
      expect(page).to have_content('Highly skilled infrastructure engineer')
    end

    it 'has the Selected Employment section' do
      expect(page).to have_content('Selected Employment')
    end

    it 'lists Gusto role' do
      expect(page).to have_content('Staff Engineer, Datastores Infrastructure')
      expect(page).to have_content('Gusto')
      expect(page).to have_content('August 2024 - Present')
    end

    it 'lists PlanetScale role' do
      expect(page).to have_content('Engineer, Orchestration')
      expect(page).to have_content('PlanetScale')
      expect(page).to have_content('July 2021 - March 2024')
    end

    it 'lists Percy role' do
      expect(page).to have_content('Senior Software Engineer')
      expect(page).to have_content('Percy.io (acquired by BrowserStack)')
    end

    it 'lists Stitch Fix role' do
      expect(page).to have_content('Lead Engineer')
      expect(page).to have_content('Stitch Fix')
    end

    it 'lists Hydra Development role' do
      expect(page).to have_content('Owner & CEO')
      expect(page).to have_content('Hydra Development, Inc., San Francisco, California')
    end

    it 'lists Cloud City role' do
      expect(page).to have_content('Senior Developer')
      expect(page).to have_content('Cloud City Development, San Francisco, California')
    end

    it 'lists John McNeil Studio role' do
      expect(page).to have_content('Application Developer')
      expect(page).to have_content('John McNeil Studio, Berkeley, California')
    end

    it 'lists Traction Corporation role' do
      expect(page).to have_content('Web/Applications Developer')
      expect(page).to have_content('Traction Corporation, San Francisco, California')
    end

    it 'has the Education section' do
      expect(page).to have_content('Education')
      expect(page).to have_content('Cabrillo College')
      expect(page).to have_content('University of California, Santa Cruz')
      expect(page).to have_content('El Molino High School')
    end

    it 'has the References section' do
      expect(page).to have_content('References')
      expect(page).to have_content('Available upon request')
    end

    it 'has technology tags' do
      expect(page).to have_css('span.tech', minimum: 5)
    end

    it 'does not have the homepage masthead' do
      expect(page).not_to have_css('.page-masthead')
    end

    it 'does not show blog article title and attribution' do
      expect(page).not_to have_css('h1.page-title')
      expect(page).not_to have_css('aside.attribution')
    end
  end

  describe 'contact page /contact/' do
    before { visit '/contact/' }

    it 'has the site name as the page title' do
      expect(page).to have_title('Sascha Faun Winter')
    end

    it 'has the navigation header' do
      expect(page).to have_css('header.navbar')
    end

    it 'has the Contact heading' do
      expect(page).to have_content('Contact')
    end

    it 'has GPG key ID' do
      expect(page).to have_content('0x92D9A892221244C4')
    end

    it 'has email information' do
      expect(page).to have_link('hello@faun.me', href: 'mailto:hello@faun.me')
    end

    it 'has public key download link' do
      expect(page).to have_link('Download this key', href: 'https://keybase.io/faun/key.asc')
    end

    it 'links to GPG info resources' do
      expect(page).to have_link('Read more')
      expect(page).to have_link('why you should use it')
    end
  end

  describe '404 page /404.html' do
    before { visit '/404.html' }

    it 'has the site name as the page title' do
      expect(page).to have_title('Sascha Faun Winter')
    end

    it 'has the error heading' do
      expect(page).to have_content('Uh Oh!')
    end

    it 'has the error message' do
      expect(page).to have_content('We looked high and low for this page')
    end

    it 'has the elephant image' do
      expect(page).to have_css('img[src*="404"]')
    end

    it 'uses the default layout with navigation' do
      expect(page).to have_css('header.navbar')
    end
  end

  describe 'cover letter page /cover-letter/' do
    before { visit '/cover-letter/' }

    it 'uses the bare layout' do
      # Bare layout has no navbar
      expect(page).not_to have_css('header.navbar')
    end

    it 'has the page title' do
      expect(page).to have_title('Cover Letter')
    end

    it 'has the application stylesheet for print' do
      expect(page).to have_css('link[href*="application"][media="print"]', visible: false)
    end

    it 'has the greeting' do
      expect(page).to have_content('Dear Hiring Committee')
    end

    it 'mentions PlanetScale experience' do
      expect(page).to have_content('PlanetScale')
      expect(page).to have_content('Kubernetes clusters')
    end

    it 'mentions Percy experience' do
      expect(page).to have_content('Percy.io (acquired by BrowserStack)')
    end

    it 'has the Relevant Experience section' do
      expect(page).to have_content('Relevant Experience')
    end

    it 'has the What I\'m Looking for section' do
      expect(page).to have_content(/What I.m Looking for in My Next Role/)
    end

    it 'has the signature' do
      expect(page).to have_content('Faun')
    end

    it 'does not include jQuery or application JS from default layout' do
      expect(page).not_to have_css('script[src*="jquery"]', visible: false)
    end

    it 'does not include Google Analytics' do
      expect(page.html).not_to include('_gaq')
    end
  end

  describe 'khmer page /khmer/' do
    before { visit '/khmer/' }

    it 'has the site name as the page title' do
      expect(page).to have_title('Sascha Faun Winter')
    end

    it 'has the navigation header' do
      expect(page).to have_css('header.navbar')
    end

    it 'has tables with Khmer vocabulary' do
      expect(page).to have_css('table.table.table-striped.table-bordered', minimum: 1)
    end

    it 'has section headers in tables' do
      expect(page).to have_css('th.section_header', minimum: 1)
    end
  end

  describe 'blog post: Restoring Archived Files from Amazon Glacier' do
    before { visit '/posts/2012-12-16-restoring-archived-files-from-amazon-glacier-using-ruby/' }

    it 'uses the post layout wrapped in default layout' do
      expect(page).to have_css('header.navbar')
    end

    it 'has the article title in page heading' do
      expect(page).to have_css('h1.page-title', text: 'Restoring Archived Files from Amazon Glacier')
    end

    it 'has the attribution' do
      within('aside.attribution') do
        expect(page).to have_content('by')
        expect(page).to have_link('Sascha Faun Winter', href: 'https://twitter.com/faunzy')
      end
    end

    it 'wraps content in an article tag' do
      expect(page).to have_css('article')
    end

    it 'has a back link' do
      expect(page).to have_link('←Back', href: '/')
    end

    it 'has the post content' do
      expect(page).to have_content('The Problem')
    end

    it 'does not have the homepage masthead' do
      expect(page).not_to have_css('.page-masthead')
    end
  end

  describe 'blog post: Installing RSpec, FactoryGirl and Capybara with Rails 3.2' do
    before { visit '/posts/2013-01-27-installing-rspec-factorygirl-and-capybara-with-rails-32/' }

    it 'has the article title' do
      expect(page).to have_css('h1.page-title', text: 'Installing RSpec, FactoryGirl and Capybara with Rails 3.2')
    end

    it 'has the attribution' do
      expect(page).to have_css('aside.attribution')
    end

    it 'wraps content in an article tag' do
      expect(page).to have_css('article')
    end

    it 'has a back link' do
      expect(page).to have_link('←Back', href: '/')
    end

    it 'has the post content' do
      expect(page).to have_content('Generating a new Rails app without Test::Unit')
    end
  end

  describe 'blog post: Decrypting PDFs as a Service' do
    before { visit '/posts/2014-04-29-decrypting-pdfs-as-a-service/' }

    it 'has the article title' do
      expect(page).to have_css('h1.page-title', text: 'Decrypting PDFs as a Service')
    end

    it 'has the attribution' do
      expect(page).to have_css('aside.attribution')
    end

    it 'wraps content in an article tag' do
      expect(page).to have_css('article')
    end

    it 'has a back link' do
      expect(page).to have_link('←Back', href: '/')
    end

    it 'has the post content' do
      expect(page).to have_content('decrypt encrypted PDFs')
    end
  end

  describe 'blog post: Cross-compiling Golang Applications for Synology 1513+' do
    before { visit '/posts/2015-02-17-cross-compiling-golang-applications-for-synology-1513/' }

    it 'has the article title' do
      expect(page).to have_css('h1.page-title', text: 'Cross-compiling Golang Applications for Synology 1513+')
    end

    it 'has the attribution' do
      expect(page).to have_css('aside.attribution')
    end

    it 'wraps content in an article tag' do
      expect(page).to have_css('article')
    end

    it 'has a back link' do
      expect(page).to have_link('←Back', href: '/')
    end

    it 'has the post content' do
      expect(page).to have_content('Synology NAS architecture')
    end
  end

  describe 'feed /feed.xml' do
    before { visit '/feed.xml' }

    it 'returns XML content' do
      expect(page.body).to include('<?xml') .or include('<rss') .or include('<feed')
    end

    it 'is a valid RSS feed' do
      expect(page.body).to include('<rss').or include('<feed')
    end

    it 'contains blog article entries' do
      expect(page.body).to include('<item>').or include('<entry>')
    end
  end

  describe 'static files' do
    it 'serves the CNAME file' do
      visit '/CNAME'
      expect(page.status_code).to eq(200)
    end

    it 'serves the keybase.txt file' do
      visit '/keybase.txt'
      expect(page.status_code).to eq(200)
      expect(page.body).to include('keybase.io/faun')
    end
  end

  describe 'layout assignments' do
    it 'homepage uses default layout' do
      visit '/'
      # Default layout has the navbar and page-masthead on index
      expect(page).to have_css('header.navbar')
      expect(page).to have_css('.page-masthead')
    end

    it 'resume uses default layout' do
      visit '/resume/'
      expect(page).to have_css('header.navbar')
      expect(page).not_to have_css('.page-masthead')
    end

    it 'contact uses default layout' do
      visit '/contact/'
      expect(page).to have_css('header.navbar')
    end

    it '404 uses default layout' do
      visit '/404.html'
      expect(page).to have_css('header.navbar')
    end

    it 'cover letter uses bare layout' do
      visit '/cover-letter/'
      expect(page).not_to have_css('header.navbar')
      expect(page).not_to have_css('.page-masthead')
    end

    it 'blog posts use post layout (wrapped in default)' do
      visit '/posts/2012-12-16-restoring-archived-files-from-amazon-glacier-using-ruby/'
      expect(page).to have_css('header.navbar')
      expect(page).to have_css('article')
      expect(page).to have_link('←Back', href: '/')
    end
  end

  describe 'page content structure' do
    it 'homepage shows bio content inside .bio container' do
      visit '/'
      within(all('.bio').last) do
        expect(page).to have_content('Goals')
      end
    end

    it 'non-homepage pages render inside .container > .row > .container' do
      visit '/resume/'
      expect(page).to have_css('.container .row .container')
    end

    it 'blog posts show article title as h1.page-title' do
      visit '/posts/2014-04-29-decrypting-pdfs-as-a-service/'
      expect(page).to have_css('h1.page-title', text: 'Decrypting PDFs as a Service')
    end

    it 'blog posts have attribution with author link' do
      visit '/posts/2014-04-29-decrypting-pdfs-as-a-service/'
      within('aside.attribution') do
        expect(page).to have_link('Sascha Faun Winter', href: 'https://twitter.com/faunzy')
      end
    end

    it 'post layout includes article element and back navigation' do
      visit '/posts/2013-01-27-installing-rspec-factorygirl-and-capybara-with-rails-32/'
      expect(page).to have_css('.section.center-block article')
      expect(page).to have_css('aside nav a.btn', text: '←Back')
    end
  end
end
