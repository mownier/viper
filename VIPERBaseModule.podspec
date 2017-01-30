Pod::Spec.new do |s|
    s.name = 'VIPERBaseModule'
    s.version = '0.0.1'
    s.summary = 'Base module for VIPER architectur'
    s.platform = :ios, '9.0'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.homepage = 'https://github.com/mownier/viper-base-module'
    s.author = { 'Mounir Ybanez' => 'rinuom91@gmail.com' }
    s.source = { :git =>'https://github.com/mownier/viper-base-module.git', :branch => 'master' }
    s.source_files = 'VIPER\ Base\ Module/Source/*.swift'
    s.requires_arc = true
end
