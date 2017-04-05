Pod::Spec.new do |s|
    s.name = 'Viper'
    s.version = '1.1.2'
    s.summary = 'Skeleton of a Viper module.'
    s.platform = :ios, '9.0'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.homepage = 'https://github.com/mownier/viper'
    s.author = { 'Mounir Ybanez' => 'rinuom91@gmail.com' }
    s.source = { :git =>'https://github.com/mownier/viper.git', :tag => '1.1.2' }
    s.source_files = 'Viper/Source/*.swift'
    s.requires_arc = true
end
