package MusicBrainz::Server::Entity::ArtistCreditName;

use Moose;
use MusicBrainz::Server::Entity::Types;
use aliased 'MusicBrainz::Server::Entity::ArtistCreditNameDisplayMode';
use MusicBrainz::Server::Entity::Util::JSON qw( to_json_object );

has 'name' => (
    is => 'rw',
    isa => 'Str'
);

has 'join_phrase' => (
    is => 'rw',
    isa => 'Str'
);

has 'artist_id' => (
    is => 'rw',
    isa => 'Int'
);

has 'artist' => (
    is => 'rw',
    isa => 'Artist'
);

has 'display_mode_id' => (
    is => 'rw',
    isa => 'Int'
);

has 'display_mode' => (
    is => 'rw',
    isa => 'ArtistCreditNameDisplayMode',
);

sub display_mode_name
{
    my ($self) = @_;
    return $self->display_mode ? $self->display_mode->name : undef;
}

sub l_display_mode_name
{
    my ($self) = @_;
    return $self->display_mode ? $self->display_mode->l_name : undef;
}

sub TO_JSON {
    my ($self) = @_;

    return {
        artist      => $self->artist->TO_JSON,
        joinPhrase  => $self->join_phrase,
        display_mode_id => $self->display_mode_id,
        displayMode => to_json_object($self->display_mode),
        # displayMode =>  $self->display_mode->TO_JSON,
        # $self->display_mode ? (displayMode => $self->display_mode->TO_JSON) : (),
        # displayMode => $self->display_mode ? (display_mode => $self->display_mode->TO_JSON) : (),
        name        => $self->name,
    };
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 Lukas Lalinsky

This file is part of MusicBrainz, the open internet music database,
and is licensed under the GPL version 2, or (at your option) any
later version: http://www.gnu.org/licenses/gpl-2.0.txt

=cut
