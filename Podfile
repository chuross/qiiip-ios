platform :ios, '10.0'

target 'qiiip' do
  use_frameworks!

  pod 'RxSwift', '~> 3.0'
  pod 'RxCocoa', '~> 3.0'
  pod 'KeychainAccess', '~> 3.0'
  pod 'CHQiitaApiClient', :git => 'https://github.com/chuross/CHQiitaApiClient.git', :tag => '0.0.13'
  pod 'SDWebImage', '~> 4.1'
  pod 'XLPagerTabStrip', '~> 8.0'
  pod 'APAvatarImageView'
  pod 'Eureka', :git => 'https://github.com/xmartlabs/Eureka', :branch => 'feature/Xcode9-Swift3_2'
end

plugin 'cocoapods-keys', {
  :project => "qiiip",
  :keys => [
    'QiitaClientId',
    'QiitaClientSecret'
  ]
}
