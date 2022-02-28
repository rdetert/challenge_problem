import React from "react";
import PlayerRow from "./PlayerRow.js"
import PlayerFormRow from "./PlayerFormRow.js"
import { getIndex, create, update, destroy } from '../../services/crud.js';


const PlayerTable = props => {
  const { csrfToken } = props;

  const blankPlayer = {
    id: 0,
    first_name: '',
    last_name: '',
    birthdate: '',
    gender: ''
  };

  const [players, setPlayers] = React.useState([]);
  const [newPlayer, setNewPlayer] = React.useState(blankPlayer);
  const [editRowId, setEditRowId] = React.useState(0);

  const myFetch = React.useCallback( async () => {
    getIndex('/players.json')
      .then(json => {
        setPlayers(json);
      })
    }, []);

  React.useEffect( () => {
    myFetch();
  }, [myFetch]);


  const handleEditClick = (event, player) => {
    event.preventDefault();
    setEditRowId(player.id);
  }

  const handleUpdate = (event, player) => {
    event.preventDefault();
    update(`players/${player.id}.json`, {record: player, props: props}, (json) => {
      setPlayers(json);
      setEditRowId(0);
    });
  }

  const handleCreate = (event, player) => {
    event.preventDefault();
    create(`players.json`, {record: player, props: props}, (json) => {
      setPlayers(json);
      setNewPlayer(blankPlayer);
    });
  }

  const handleDestroy = (event, player) => {
    event.preventDefault();
    destroy(`players/${player.id}.json`, {props: props}, (json) => {
      setPlayers(json);
    });
  }


  return (
    <div className="flex flex-col">
      <div className="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
        <div className="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
          <div className="shadow overflow-hidden border-b border-gray-200 sm:rounded-lg">
            <form id="playerTableForm">

              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-50">
                  <tr>
                    <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      First Name
                    </th>
                    <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Last Name
                    </th>
                    <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Birthday
                    </th>
                    <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Years Old
                    </th>
                    <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      Gender
                    </th>
                    <th scope="col" className="relative px-6 py-3">
                      <span className="sr-only">Edit</span>
                    </th>
                    <th scope="col" className="relative px-6 py-3">
                      <span className="sr-only">Delete</span>
                    </th>
                  </tr>
                </thead>
                <tbody>
                  {players.map((player, idx) => {                    
                    return (
                      (editRowId === player.id) ? 
                        (<PlayerFormRow key={player.id} klass={'hover:bg-slate-50'} player={player} handleSubmit={handleUpdate} />)
                      :
                        (<PlayerRow key={player.id} klass={'hover:bg-slate-50'} player={player} handleEditClick={handleEditClick} handleDestroy={handleDestroy} />)
                      )
                    }
                  )}
                  <PlayerFormRow klass={'bg-white'} player={newPlayer} handleSubmit={handleCreate} action={'new'} />
                </tbody>
              </table>
            </form>
          </div>
        </div>
      </div>
    </div>
  )

}

export default PlayerTable;