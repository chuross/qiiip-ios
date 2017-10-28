platform :ios, '10.0'

target 'qiiip' do
  use_frameworks!

  pod 'RxSwift', '~> 3.0'
  pod 'RxCocoa', '~> 3.0'
  pod 'KeychainAccess', '~> 3.0'
  pod 'CHQiitaApiClient', :git => 'https://github.com/chuross/CHQiitaApiClient.git', :tag => '0.0.12'
  pod 'SDWebImage', '~> 4.1'
  pod 'XLPagerTabStrip', '~> 8.0'
  pod 'APAvatarImageView'
end

plugin 'cocoapods-keys', {
  :project => "qiiip",
  :keys => [
    'QiitaClientId',
    'QiitaClientSecret'
  ]
}
