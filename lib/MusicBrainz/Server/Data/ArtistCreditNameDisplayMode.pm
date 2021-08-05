package MusicBrainz::Server::Data::ArtistCreditNameDisplayMode;
use Moose;
use namespace::autoclean;

use MusicBrainz::Server::Entity::ArtistCreditNameDisplayMode;
use MusicBrainz::Server::Data::Utils qw(
    load_subobjects
    placeholders
);

extends 'MusicBrainz::Server::Data::Entity';
with 'MusicBrainz::Server::Data::Role::EntityCache';
with 'MusicBrainz::Server::Data::Role::SelectAll';
with 'MusicBrainz::Server::Data::Role::OptionsTree';
with 'MusicBrainz::Server::Data::Role::Attribute';

sub _type { 'artist_credit_name_display_mode' }

sub _table
{
    return 'artist_credit_name_display_mode';
}

sub _entity_class
{
    return 'MusicBrainz::Server::Entity::ArtistCreditNameDisplayMode';
}

sub load
{
    my ($self, @objs) = @_;
    load_subobjects($self, 'artist_credit_name_display_mode', @objs);
}

sub in_use {
    my ($self, $id) = @_;
    return $self->sql->select_single_value(
        'SELECT 1 FROM artist_credit_name WHERE display_mode = ? LIMIT 1',
        $id);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

=head1 COPYRIGHT AND LICENSE

This file is part of MusicBrainz, the open internet music database,
and is licensed under the GPL version 2, or (at your option) any
later version: http://www.gnu.org/licenses/gpl-2.0.txt

=cut
