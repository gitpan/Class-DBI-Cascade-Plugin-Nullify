package Class::DBI::Cascade::Plugin::Nullify;

=head1 NAME

Class::DBI::Cascade::Plugin::Nullify - Nullify related Class::DBI objects

=head1 SYNOPSIS

    package Music::Artist;
    #define your class here
    Music::Artist->has_many(cds => 'Music::CD', {cascade => 'Class::DBI::Cascade::Plugin::Nullify'});

=head1 DESCRIPTION

This is a cascading nullify strategy (i.e. 'on delete set null') that will nullify any related Class::DBI objects.

=cut

use strict;
use warnings;

use base 'Class::DBI::Cascade::None';

our $VERSION = 0.03;


=head1 METHODS

=over 4

=item cascade

implementation of the cascading nullify strategy.

=back

=cut

sub cascade 
{
	my ($self, $obj) = @_;
	my $foreign_objects = $self->foreign_for($obj); #get all foreign objects
	my $foreign_key = $self->{_rel}->args->{foreign_key}; #get the foreign key
	
	while ( my $foreign_object = $foreign_objects->next)
	{	
		$foreign_object->$foreign_key(undef); #set foreign_key value to null
		$foreign_object->update(); #update the object
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