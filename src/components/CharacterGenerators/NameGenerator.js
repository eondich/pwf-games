export const fetchCharacterNameWithGender = async (baseUrl, nameGender, ancestryId) => {
  let url = baseUrl.concat(`/gender/${nameGender}`);
  
  if (ancestryId > -1) {
    url = url.concat(`/${ancestryId}`);
  }

  return fetchCharacterName(url, ancestryId);
}

export const fetchCharacterNameWithStyle = async (baseUrl, nameStyle, ancestryId) => {
  let url = nameStyle ? baseUrl.concat(`/style/${nameStyle}`) : baseUrl.concat('/style/-1');

  if (ancestryId > -1) {
    url = url.concat(`/${ancestryId}`);
  }

  return fetchCharacterName(url, ancestryId);
}

const fetchCharacterName = async (url) => {
  return fetch(url, {
    method: 'get'
  }).then((res) => {
    return res.json();
  }).then((res) => {
    return res.character_name;
  });
}
