use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'WWW::RapidShare',
    VERSION_FROM      => 'lib/WWW/RapidShare.pm', # finds $VERSION
    PREREQ_PM         => {
        'Class::Accessor'   => 0,
        'WWW::Mechanize'    => 0, 
        'version'           => 0, 
    }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/WWW/RapidShare.pm', # retrieve abstract from module
       AUTHOR         => 'Rohan Almeida <rohan@almeida.in>') : ()),
);
