Pod::Spec.new do |s|

  s.name         = "RTLoading"
  s.version      = "1.0.1"
  s.summary      = "Loading indicator."

  s.description  = <<-DESC
                   RTLoading is a extension which allow easy add loading indicator into any view.
                   DESC

  s.homepage     = "https://github.com/RTILab/RTDataSourceAdapter"

  s.license      = "MIT"

  s.author             = { "Ivan  Morozov" => "w-e-r-n-e-r@bk.ru" }
  s.social_media_url   = "https://ru-ru.facebook.com/people/Ivan-Morozov/100006824496626"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/RTILab/RTLoading.git", :branch => "master", :tag => s.version.to_s }

  s.source_files = "src/RTLoading/*"
  s.source_files  = "src/RTLoading/Views/RTloadingIndicator/*"

end
