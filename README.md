# NAME

Dancer2::Session::PSGI - Dancer2 session storage via Plack::Middleware::Session

# VERSION

version 0.004

# SYNOPSIS

    use Dancer2;

    setting( session => 'PSGI' );

    get '/' => sub {
        my $count = session("counter");
        session "counter" => ++$count;
        return "This is my ${count}th dance";
    };

# DESCRIPTION

This module implements implements a session factory for Dancer2 that uses
[Plack::Middleware::Session](http://search.cpan.org/perldoc?Plack::Middleware::Session) for session management.

# CONFIGURATION

The setting __session__ should be set to `PSGI` in order to use this session
engine in a Dancer2 application.

The default cookie name is `plack_session`. Refer to
["Session\_engine" in Dancer2::Config](http://search.cpan.org/perldoc?Dancer2::Config#Session\_engine) if you need to modify this.

# ACKNOWLEDGEMENTS

The methods required by [Dancer2::Core::Role::SessionFactory](http://search.cpan.org/perldoc?Dancer2::Core::Role::SessionFactory) were
heavily based on [Dancer2::Session::Cookie](http://search.cpan.org/perldoc?Dancer2::Session::Cookie) by David Golden.

# AUTHOR

Russell Jenkins <russellj@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Russell Jenkins.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
