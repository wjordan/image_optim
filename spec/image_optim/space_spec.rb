$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require 'rspec'
require 'image_optim/space'

describe ImageOptim::Space do
  Space = ImageOptim::Space

  {
    0           => '      ',
    1           => '    1B',
    10          => '   10B',
    100         => '  100B',
    1_000       => ' 1000B',
    10_000      => '  9.8K',
    100_000     => ' 97.7K',
    1_000_000   => '976.6K',
    10_000_000  => '  9.5M',
    100_000_000 => ' 95.4M',
  }.each do |size, space|
    it "should convert #{size} to #{space}" do
      expect(Space.space(size)).to eq(space)
    end
  end
end
