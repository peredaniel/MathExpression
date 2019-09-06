Pod::Spec.new do |spec|
  spec.name         = 'MathExpression'
  spec.version      = '1.1.0'
  spec.summary      = 'Framework to parse and evaluate arithmetic mathematical expressions given by a String'
  spec.description  = 'This framework provides an algorithm and an API to easily evaluate arithmetic mathematical expressions given by a String. In addition to the basic arithmetic operators (addition, subtraction, product and division), we can pass in a transformation (in the form of a block) to add flexibility in the expressions provided.'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = 'https://github.com/peredaniel/MathExpression'
  spec.authors      = { 'Pere Daniel Prieto' => 'math.pedro.daniel.prieto@gmail.com' }
  spec.source       = { :git => 'https://github.com/peredaniel/MathExpression.git', :tag => spec.version }

  spec.platform = :ios, :tvos, :osx
  spec.ios.deployment_target  = '10.0'
  spec.tvos.deployment_target  = '10.0'
  spec.osx.deployment_target = '10.10'

  spec.swift_version = "5.0"

  spec.ios.source_files = ['MathExpression/**/*.{h,m,swift}']
  spec.tvos.source_files = ['MathExpression/**/*.{h,m,swift}']
  spec.osx.source_files = ['MathExpression/Source/**/*.{h,m,swift}']
end
