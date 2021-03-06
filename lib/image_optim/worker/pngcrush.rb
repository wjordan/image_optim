require 'image_optim/worker'

class ImageOptim
  class Worker
    # http://pmt.sourceforge.net/pngcrush/
    class Pngcrush < Worker
      CHUNKS_OPTION =
      option(:chunks, :alla, Array, 'List of chunks to remove or '\
          '`:alla` - all except tRNS/transparency or '\
          '`:allb` - all except tRNS and gAMA/gamma') do |v|
        Array(v).map(&:to_s)
      end

      FIX_OPTION =
      option(:fix, false, 'Fix otherwise fatal conditions '\
          'such as bad CRCs'){ |v| !!v }

      BRUTE_OPTION =
      option(:brute, false, 'Brute force try all methods, '\
          'very time-consuming and generally not worthwhile'){ |v| !!v }

      # Always run first [-1]
      def run_order
        -1
      end

      def optimize(src, dst)
        args = %W[-reduce -cc -q -- #{src} #{dst}]
        chunks.each do |chunk|
          args.unshift '-rem', chunk
        end
        args.unshift '-fix' if fix
        args.unshift '-brute' if brute
        execute(:pngcrush, *args) && optimized?(src, dst)
      end
    end
  end
end
