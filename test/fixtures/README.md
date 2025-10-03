# TMDB API Test Fixtures

This directory contains sample JSON responses from the TMDB API for testing purposes.

## Purpose

These fixture files are used to mock API responses during testing, allowing for:
- Consistent test data across different test suites
- Offline testing without requiring actual API calls
- Testing of edge cases and error scenarios

## Files

- `movie_details.json` - Sample movie details response
- `tv_show_details.json` - Sample TV show details response
- `person_details.json` - Sample person details response

## Usage

These fixtures can be used with mocking libraries (like `http_mock_adapter`) to simulate API responses in unit and integration tests.

## Note

The data in these files is for testing purposes only and may not reflect the current state of the TMDB API.