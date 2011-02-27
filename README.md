# Bierdopje API Wrapper

This is a gem which wraps the [Bierdopje](http://www.bierdopje.com/) API. It will allow you to find subtitles uploaded to [bierdopje.com](http://www.bierdopje.com/).

## Basic Usage

Basic usage will follow later together with documentation. For now, this is an overview of the methods you can use:

### Show
    Show.find id                  # => Will retrieve the Show based on it's bierdopje.com id
    Show.find_by_name name        # => Will retrieve the Show based on it's exact name
    Show.find_by_tvdb_id id       # => Will retrieve the Show based on it's id on tvdb.com
    Show.search query             # => Will search the database based on the show's name

    show.episodes                 # => returns an array with all Episodes for this Show
    show.episodes(:season => id)  # => returns an array with all Episodes for the given season for this Show
    show.subtitles(season_number) # => returns an array with all Subtitles for the given season for this Show

### Episode

    Episode.find id               # => Will retrieve the Episode based on it's bierdopje.com id

    episode.show                  # => Will retrieve the Show to which this Episode belongs
    episode.subtitles             # => returns an array with all Subtitles for this Episode

### Subtitle

    Subtitle.find show_id, season_number, episode_number
                                  # => Will retrieve all Subtitles which fall in the given scope

## Bugs

Please report them on the [Github issue tracker](https://github.com/jeroenj/bierdopje/issues)
for this project.

If you have a bug to report, please include the following information:

* **Version information for bierdopje, Rails and Ruby.**
* Stack trace and error message.

You may also fork this project on Github and create a pull request.
Do not forget to include tests.

Copyright (c) 2011, released under the MIT license.
