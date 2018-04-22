import PropTypes from 'prop-types'
import React from 'react'
import {Map, InfoWindow, Marker, GoogleApiWrapper} from 'google-maps-react';

// Map Container using https://github.com/fullstackreact/google-maps-react


export class MapContainer extends React.Component {
  render() {
    return (
      <Map 
      google={this.props.google}
      zoom={12}
      initialCenter={
        {
          lat: -16.9186,
          lng: 145.7781,
        }
      }
      >
        <Marker onClick={this.onMarkerClick} name={'Current location'} />
        <Marker position={{lat: -16.8778, lng: 145.7499,}} name={'Cairns airport'} />
        <Marker position={{lat: -16.944205, lng: 145.739841,}} name={'Cairns supermarket'} />
        <Marker position={{lat: -16.938762, lng: 145.746183,}} name={'Cairns third address'} />
        <Marker position={{lat: -16.933050, lng: 145.753282,}} name={'Cairns central ATM'} />
        <Marker position={{lat: -16.926877, lng: 145.740750,}} name={'Cairns rando location'} />

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
