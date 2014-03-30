package Dancer2::Session::PSGI;

# ABSTRACT: Dancer2 session storage via Plack::Middleware::Session

use Moo;
with 'Dancer2::Core::Role::SessionFactory';

# VERSION

#-----------------------------------------#
# Alter SessionFactory attribute defaults
#-----------------------------------------#

has '+cookie_name' => ( default => 'plack_session' );

#-----------------------------------------#
# SessionFactory implementation methods
#-----------------------------------------#

# Get middleware session hash
sub _retrieve {
    shift->context->request->env->{'psgix.session'};
}

# Put data back/into middleware session hash
sub _flush {
    my ( $self, $id, $data ) = @_;
    $self->context->request->env->{'psgix.session'} = $data;
}

# Middleware handles cookie expiry
sub _destroy { return }

# Its the responsibility of Plack::Middleware::Session for
# tracking other sessions (we know nothing about them).
# So return an empty list.
sub _sessions { return [] }

#-----------------------------------------#
# Overridden methods from SessionFactory
#-----------------------------------------#

# Middleware sets the cookie.
# Set options.expire if cookie has expired, e.g. result of delete_session.
sub set_cookie_header {
    my ( $self, %params ) = @_;
    my $session = $params{session};
    if ( $session->expires && $session->expires < time ) {
        $self->context->env->{'psgix.session.options'}{expire} = 1;
    }
}

1;

__END__

=for Pod::Coverage method_names_here
set_cookie_header

=encoding utf-8

=head1 SYNOPSIS

    use Dancer2;

    setting( session => 'PSGI' );

    get '/' => sub {
        my $count = session("counter");
        session "counter" => ++$count;
        return "This is my ${count}th dance";
    };

=head1 DESCRIPTION

This module implements implements a session factory for Dancer2 that uses
L<Plack::Middleware::Session> for session management.

=head1 CONFIGURATION

The setting B<session> should be set to C<PSGI> in order to use this session
engine in a Dancer2 application.

The default cookie name is C<plack_session>. Refer to
L<Dancer2::Config/Session_engine> if you need to modify this.

=head1 ACKNOWLEDGEMENTS

The methods required by L<Dancer2::Core::Role::SessionFactory> were
heavily based on L<Dancer2::Session::Cookie> by David Golden.

=cut
