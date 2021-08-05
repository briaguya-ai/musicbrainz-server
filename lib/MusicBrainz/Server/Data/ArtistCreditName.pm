package MusicBrainz::Server::Data::ArtistCreditName;
use Moose;
use namespace::autoclean;

use Data::Compare;
use Carp qw( cluck );

use MusicBrainz::Server::Entity::Artist;
use MusicBrainz::Server::Entity::ArtistCredit;
use MusicBrainz::Server::Entity::ArtistCreditName;
use MusicBrainz::Server::Data::Artist qw( is_special_purpose );
use MusicBrainz::Server::Data::Utils qw( placeholders load_subobjects type_to_model sanitize );
use MusicBrainz::Server::Constants qw( entities_with );

extends 'MusicBrainz::Server::Data::Entity';
with 'MusicBrainz::Server::Data::Role::EntityCache';
with 'MusicBrainz::Server::Data::Role::Editable' => {
    table => 'artist_credit_name',
};

sub _type { 'artist_credit_name' }

sub _columns
{
    return 'artist_credit_name.artist_credit, artist_credit_name.position, ' .
           'artist_credit_name.artist, artist_credit_name.name, ' .
           'artist_credit_name.join_phrase, display_mode';
}

sub _column_mapping
{
    return {
        id => 'id',
        artist_credit_id => 'artist_credit',
        position => 'position',
        artist_id => 'artist',
        name => 'name',
        join_phrase => 'join_phrase',
        display_mode_id => 'display_mode'
    };
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

=head1 COPYRIGHT AND LICENSE

This file is part of MusicBrainz, the open internet music database,
and is licensed under the GPL version 2, or (at your option) any
later version: http://www.gnu.org/licenses/gpl-2.0.txt

=cut
