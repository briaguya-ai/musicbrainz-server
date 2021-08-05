package MusicBrainz::Server::Entity::ArtistCreditNameDisplayMode;

use Moose;
use MusicBrainz::Server::Translation::Attributes qw( lp );

use aliased 'MusicBrainz::Server::Entity::ArtistCreditName';

extends 'MusicBrainz::Server::Entity';

with 'MusicBrainz::Server::Entity::Role::OptionsTree' => {
    type => 'ArtistCreditNameDisplayMode',
};

sub entity_type { 'artist_credit_name_display_mode' }

sub l_name {
    my $self = shift;
    return lp($self->name, 'artist_credit_name_display_mode')
}

sub TO_JSON {
    my ($orig, $self) = @_;
    return {
        %{ $self->$orig },
        name => covert_to_json($self->name)
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
