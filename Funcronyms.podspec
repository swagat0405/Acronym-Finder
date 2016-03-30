

Pod::Spec.new do |s|

    s.name = 'Funcronyms'
    s.version = '1.0'
    s.summary = 'Simple app to find full forms for acronyms/initialisms.'
    s.homepage = 'https://github.com/swagat0405/Acronym-Finder'
    s.license = {
        :type => 'MIT',
        :file => 'LICENSE'
    }
    s.author = {
        'swagat0405' => 'swagat_mishra1990@hotmail.com'
    }
    s.source = {
        :git => 'https://github.com/swagat0405/Acronym-Finder.git',
        :tag => "v#{s.version}"
    }
    s.platform = :ios, '8.0'
    s.dependency 'AFNetworking' , '~>2.0'
    s.dependency 'MBProgressHUD', '~>0.9.2'
    s.source_files = 'Funcronyms/*.{m,h}'
    s.requires_arc = true

end
