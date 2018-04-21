import PropTypes from 'prop-types'
import React from 'react'
import {Map, InfoWindow, Marker, GoogleApiWrapper} from 'google-maps-react';

// Map Container using https://github.com/fullstackreact/google-maps-react


export class MapContainer extends React.Component {
  render() {
    return (
      <Map 
      google={this.props.google}
      zoom={9}
      initialCenter={
        {
          lat: -16.9186,
          lng: 145.7781,
        }
      }
      >
        <Marker onClick={this.onMarkerClick} name={'Current location'} />

        <InfoWindow onClose={this.onInfoWindowClose}>
          <div>
            <h1>sample title</h1>
          </div>
        </InfoWindow>
      </Map>
    )
  }
}

export default GoogleApiWrapper({
  apiKey: "AIzaSyBxusuluK-dZTBLOUZ44EbPjtY-0TKQBDE",
})(MapContainer)
