package WWW::RapidShare;
use strict; use warnings;
use base 'Class::Accessor';

use version; our $VERSION = qv('0.1');

use WWW::Mechanize;
use File::Basename;

__PACKAGE__->mk_accessors(qw/
    url
    account_id
    password
    _mech
/);

=pod

=head1 NAME
 
WWW::RapidShare - Download files from Rapidshare
 
 
=head1 VERSION
 
This documentation refers to WWW::RapidShare version 0.1
 
 
=head1 NOTE

    Currently only works with rapidshare.com PREMIUM accounts.
    More features coming soon!

=head1 SYNOPSIS
 
    use WWW::RapidShare;

    my $rapid = WWW::RapidShare->new();

    $rapid->url('http://rapidshare.com/files/file.zip');
    $rapid->account_id('xxxxxx');
    $rapid->password('xxxxxx');
    
    # Download the file associated with the above URL.
    # It will be saved in current directory.
    $rapid->download_file();
  
  
=head1 SUBROUTINES/METHODS 
 
=cut

=pod

=head2 B<new()>

=head3 Purpose

    Create a new WWW::RapidShare object

=head3 Usage

    my $rapid = WWW::RapidShare->new();

=head3 Parameters

    None

=head3 Returns

    A WWW::RapidShare object

=cut
sub new
{
    my ($proto) = @_;

    my $class = ref $proto || $proto;
    my $self = {};

    bless $self, $class;

    # Create our agent
    my $mech = WWW::Mechanize->new();
    $self->_mech($mech);

    return $self;
}

=pod

=head2 B<accessors/mutators>

    * url - The URL to download the file
    * account_id - Your account ID
    * password - your password

=cut
=pod

=head2 B<download_file()>

=head3 Purpose

    Download the file associated with the URL

=head3 Usage

    $rapid->download_file();

=head3 Parameters

    None

=head3 Returns

    None

=head3 Comments

    This method will create a file in the current directory

=cut
sub download_file
{
    my $self = shift;

    $self->_mech->get($self->url);
    $self->_mech->click_button(value => 'PREMIUM');

    # login
    $self->_mech->form_with_fields(qw/accountid password/);
    $self->_mech->field(accountid => $self->account_id);
    $self->_mech->field(password => $self->password);
    $self->_mech->submit();

    $self->_mech->form_with_fields(qw/l p/);
    $self->_mech->submit();

    $self->_mech->click_button(value => 'PREMIUM');

    # get TeliaSonera links
    # TODO: support all mirrors
    my $telia_link = $self->_mech->find_link( text_regex => qr/Download via TeliaSonera/ );
    my $file_name = basename($telia_link->url);

    print "Fetching " . $telia_link->url . " ...\n";
    print "Saving file as $file_name\n";
    $self->_mech->get( $telia_link->url, ":content_file" => $file_name );
}

1;

=head1 DEPENDENCIES
 
=over 4

=item * Class::Accessor

=item * WWW::Mechanize

=back

=head1 AUTHOR
 
Rohan Almeida <rohan@almeida.in>
 
 
=head1 LICENCE AND COPYRIGHT
 
Copyright (c) 2008 Rohan Almeida <rohan@almeida.in>. All rights
reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

