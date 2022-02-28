export function getIndex(url) {
  return fetch(url, {
    headers: {
      'Content-Type': 'application/json'
    },
  })
    .then(data => data.json());
}

export function create(url, obj, callback) {
  return fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': obj.props.csrfToken
    },
    body: JSON.stringify({ [obj.props.modelName]: obj.record })
  })
  .then(data => data.json())
  .then( json => {
    callback.call(this, json);
  });
}

export function update(url, obj, callback) {
  return fetch(url, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': obj.props.csrfToken
    },
    body: JSON.stringify({ [obj.props.modelName]: obj.record })
  })
  .then( data => data.json() )
  .then( json => {
    callback.call(this, json);
  });
}

export function destroy(url, obj, callback) {
  return fetch(url, {
    method: 'DELETE',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': obj.props.csrfToken
    }
  })
  .then(data => data.json())
  .then( json => {
    callback.call(this, json);
  });
}