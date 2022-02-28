import React from "react";

const PlayerRow = props => {
  const [player, setPlayer] = React.useState(props.player || {});
  const { handleEditClick, handleDestroy, klass } = props;

  return (
    <tr className={klass}>
      <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{player.first_name}</td>
      <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{player.last_name}</td>
      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{player.birthdate}</td>
      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{player.years_old}</td>
      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{player.gender}</td>
      <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
        <a href="#" className="text-indigo-600 hover:text-indigo-900" onClick={(e) => handleEditClick(e, player)}>
          Edit
        </a>
      </td>
      <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
        <a href="#" className="text-indigo-600 hover:text-indigo-900" onClick={(e) => handleDestroy(e, player)}>
          Delete
        </a>
      </td>
    </tr>
  )
}

export default PlayerRow;