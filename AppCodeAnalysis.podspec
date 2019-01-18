
Pod::Spec.new do |s|
    s.name         = 'AppCodeAnalysis'
    s.version      = '1.0.0'
    s.summary      = 'UIViewController+Swizzled. log the current UIViewController'
    s.homepage     = 'https://github.com/uldh/AppCodeAnalysis'
    s.license      = 'MIT'
    s.authors      = {'Liu Donghao' => 'uldh@163.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/uldh/AppCodeAnalysis.git', :tag => s.version}
    s.source_files = 'AppCodeAnalysis/UIViewControllerSwizzled','AppCodeAnalysis/UIViewControllerSwizzled/*.{h,m}','AppCodeAnalysis/UIViewControllerSwizzled/**/*.{h,m}'

    s.requires_arc = true
end
