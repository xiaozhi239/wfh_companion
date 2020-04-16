# wfh_companion

Working from home can be tough for many. This app hopefully could help make it easier for you.

## Contributing to the project

This is meant to be an open source project, welcome to contribute to the code base.

### Project setup

After downloading the project, you need to create `assets/configs/secrets.json` under app root folder.
And then you need to apply for one API_KEY in www.themoviedb.org, this is for the access for random
movies. Put your acquired API_KEY in `assets/configs/secrets.json`:

```json
{
  "TMDB_API_KEY": "Your own TMDB API key",
  "TMDB_READ_ACCESS_TOKEN": "You read access token (for api v4)"
}
```
