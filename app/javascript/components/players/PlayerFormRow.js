import React from "react";
import * as yup from 'yup';

const schema = yup.object().shape({
  first_name: yup.string().required(),
  last_name: yup.string().required(),
  birthdate: yup.string().required(),
  gender: yup.string().oneOf(['male', 'female', 'non-binary'])
});


const PlayerFormRow = props => {
  const [player, setPlayer] = React.useState(props.player);
  const { klass, handleSubmit, action } = props;

  React.useEffect(() => {
    setPlayer(props.player);
  }, [props.player]);

  const defaultBorderColors = {
    first_name: 'border-gray-300',
    last_name: 'border-gray-300',
    birthdate: 'border-gray-300',
    gender: 'border-gray-300',
  }
  const [inputBorderColor, setInputBorderColor] = React.useState(defaultBorderColors);

  const validateSchema = (value, callback=null) => {
    return schema
      .validate(value, {abortEarly: false})
      .then(function(value) {
        if (callback) callback();
        setInputBorderColor(defaultBorderColors);
      })
      .catch(function(err) {
        const newBorderColors = defaultBorderColors;
        console.log(err.inner);
        err.inner.forEach((field) => {
          newBorderColors[field.path] = 'border-red-500 !important'
        });
        setInputBorderColor(newBorderColors);
      });
  };

  const changeHandler = (event) => {
    event.preventDefault();
    setPlayer( {...player, [event.target.name]: event.target.value} );
  }

  const handleSubmitClick = (event, player) => {
    event.preventDefault();
    validateSchema(player, () => handleSubmit(event, player));
  }

  return (
    <tr className={klass}>
      <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
        <input
          type="text"
          name="first_name"
          id="first_name"
          className={`${inputBorderColor['first_name']} focus:ring-indigo-500 focus:border-indigo-500 w-full sm:text-sm border rounded-md py-2 px-1`}
          placeholder="Enter First Name"
          value={player.first_name}
          onChange={changeHandler}
        />
      </td>
      
      <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
        <input
          type="text"
          name="last_name"
          id="last_name"
          className={`${inputBorderColor['last_name']} focus:ring-indigo-500 focus:border-indigo-500 w-full sm:text-sm border border-gray-300 rounded-md py-2 px-1`}
          placeholder="Enter Last Name"
          value={player.last_name}
          onChange={changeHandler}
        />
      </td>
      
      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        <input
          type="date"
          name="birthdate"
          id="birthdate"
          className={`${inputBorderColor['birthdate']} focus:ring-indigo-500 focus:border-indigo-500 w-full sm:text-sm border border-gray-300 rounded-md py-2 px-1`}
          value={player.birthdate}
          onChange={changeHandler}
        />
      </td>

      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        {player.years_old}
      </td>

      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        <select
          id="gender"
          name="gender"
          className={`${inputBorderColor['gender']} block w-full pl-3 pr-10 py-3 text-sm border-gray-300 bg-slate-50 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md`}
          onChange={changeHandler}
          value={player.gender}
        >
          <option value="">Select Gender</option>
          <option value="male">Male</option>
          <option value="female">Female</option>
          <option value="non-binary">Non-Binary</option>
        </select>
      </td>
      
      <td>&nbsp;</td>

      <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
        <button
            type="button"
            className="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
            onClick={ (e) => handleSubmitClick(e, player) }
          >
            { action === 'new' ? 'Create' : 'Save'}
          </button>
      </td>
    </tr>
  )
}

export default PlayerFormRow;