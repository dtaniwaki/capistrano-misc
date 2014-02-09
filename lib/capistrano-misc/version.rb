module CapistranoMisc
  class Version
    MAJOR = 0 unless defined? CapistranoMisc::Version::MAJOR
    MINOR = 0 unless defined? CapistranoMisc::Version::MINOR
    PATCH = 5 unless defined? CapistranoMisc::Version::PATCH
    PRE = nil unless defined? CapistranoMisc::Version::PRE

    class << self
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end
    end
  end
end
