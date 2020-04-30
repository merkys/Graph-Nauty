use 5.026001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Nausparse',
    VERSION_FROM      => 'lib/Nausparse.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/Nausparse.pm', # retrieve abstract from module
    AUTHOR            => 'Andrius Merkys <merkys@cpan.org>',
    LICENSE           => 'perl',
    LIBS              => ['-lnauty'],
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
);
