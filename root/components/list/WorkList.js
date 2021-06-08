/*
 * @flow strict-local
 * Copyright (C) 2019 MetaBrainz Foundation
 *
 * This file is part of MusicBrainz, the open internet music database,
 * and is licensed under the GPL version 2, or (at your option) any
 * later version: http://www.gnu.org/licenses/gpl-2.0.txt
 */

import * as React from 'react';

import {CatalystContext} from '../../context';
import Table from '../Table';
import {
  defineArtistRolesColumn,
  defineCheckboxColumn,
  defineNameColumn,
  defineSeriesNumberColumn,
  defineTypeColumn,
  attributesColumn,
  iswcsColumn,
  ratingsColumn,
  removeFromMergeColumn,
  workRecordingArtistsColumn,
  workLanguagesColumn,
} from '../../utility/tableColumns';

type Props = {
  ...SeriesItemNumbersRoleT,
  +checkboxes?: string,
  +mergeForm?: MergeFormT,
  +order?: string,
  +showRatings?: boolean,
  +sortable?: boolean,
  +works: $ReadOnlyArray<WorkT>,
};

const WorkList = ({
  checkboxes,
  mergeForm,
  order,
  seriesItemNumbers,
  showRatings = false,
  sortable,
  works,
}: Props): React.Element<typeof Table> => {
  const $c = React.useContext(CatalystContext);

  const columns = React.useMemo(
    () => {
      const checkboxColumn = $c.user && (nonEmpty(checkboxes) || mergeForm)
        ? defineCheckboxColumn({mergeForm: mergeForm, name: checkboxes})
        : null;
      const seriesNumberColumn = seriesItemNumbers
        ? defineSeriesNumberColumn({seriesItemNumbers: seriesItemNumbers})
        : null;
      const nameColumn = defineNameColumn<WorkT>({
        order: order,
        sortable: sortable,
        title: l('Work'),
      });
      const writersColumn = defineArtistRolesColumn<WorkT>({
        columnName: 'writers',
        getRoles: entity => entity.writers,
        title: l('Writers'),
      });
      const otherArtistsColumn = defineArtistRolesColumn<WorkT>({
        columnName: 'misc_artists',
        getRoles: entity => entity.misc_artists,
        title: l('Other artists'),
      });
      const typeColumn = defineTypeColumn({
        order: order,
        sortable: sortable,
        typeContext: 'work_type',
      });

      return [
        ...(checkboxColumn ? [checkboxColumn] : []),
        ...(seriesNumberColumn ? [seriesNumberColumn] : []),
        nameColumn,
        writersColumn,
        workRecordingArtistsColumn,
        otherArtistsColumn,
        iswcsColumn,
        typeColumn,
        workLanguagesColumn,
        attributesColumn,
        ...(showRatings ? [ratingsColumn] : []),
        ...(mergeForm && works.length > 2 ? [removeFromMergeColumn] : []),
      ];
    },
    [
      $c.user,
      checkboxes,
      mergeForm,
      order,
      seriesItemNumbers,
      showRatings,
      sortable,
      works,
    ],
  );

  return <Table columns={columns} data={works} />;
};

export default WorkList;
