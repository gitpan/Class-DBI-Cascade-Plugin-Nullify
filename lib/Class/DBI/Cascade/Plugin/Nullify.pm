package Class::DBI::Cascade::Plugin::Nullify;

=head1 NAME

Class::DBI::Cascade::Plugin::Nullify - Nullify any related Class::DBI objects

=head1 SYNOPSIS

    package Music::Artist;
    #define your class here
    Music::Artist->has_many(cds => 'Music::CD', {cascade => 'Class::DBI::Cascade::Plugin::Nullify'});

=head1 DESCRIPTION

This is a Cascading Nullify strategy that will Nullify any related Class::DBI objects.

=cut

use strict;
use warnings;

use base 'Class::DBI::Cascade::None';

our $VERSION = 0.01;

sub cascade 
{
	my ($self, $obj) = @_;
	my $foreign_objects = $self->foreign_for($obj);
	my $foreign_key = $self->{_rel}->args->{foreign_key};
	
	while ( my $foreign_object = $foreign_objects->next)
	{	
		$foreign_object->$foreign_key(undef);
		$foreign_object->update();
	}
}

=head1 AUTHOR

Xufeng (Danny) Liang danny@scm.uws.edu.au

=head1 COPYRIGHT & LICENSE

Copyright 2006 Xufeng (Danny) Liang, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;