import * as mocha from 'mocha';
import * as chai from 'chai';
import chaiHttp = require('chai-http');

import app from '../src/app';

chai.use(chaiHttp);
const expect = chai.expect;

describe('Get api/v1/heroes', () => {

  it('responds with JSON array', () =>{
    return chai.request(app).get('/api/v1/heroes')
      .then(res => {
        expect(res.status).to.equal(200);
        expect(res).to.be.json;
        expect(res.body).to.be.an('array');
        expect(res.body).to.have.length(5);
      });
  });

  it('should include Wolverine', () => {
    return chai.request(app).get('/api/v1/heroes')
      .then(res => {
        let Wolverine = res.body.find(hero => hero.name === 'Wolverine');
        expect(Wolverine).to.exist;
        expect(Wolverine).to.have.all.keys([
          'id',
          'name',
          'aliases',
          'occupation',
          'gender',
          'height',
          'hair',
          'eyes',
          'powers'
        ]);
      });
  });

});

describe('Get api/v1/heroes/:id', () => {

  it('responds with a single JSON object', () => {
    return chai.request(app).get('/api/v1/heroes/1')
      .then(res => {
        expect(res.status).to.equal(200);
        expect(res).to.be.json;;
        expect(res.body).to.be.an('object');
      });
  });

  it('should return Luke Cage', () => {
    return chai.request(app).get('/api/v1/heroes/1')
      .then(res => {
        expect(res.body.hero.name).to.equal('Luke Cage');
      });
  });
})

describe('Get api/v1/heroes/name/:name', () => {
  it('should return Luke Cage', () => {
    return chai.request(app).get('/api/v1/heroes/name/lukecage')
      .then(res => {
        expect(res.body.hero).to.be.an('object')
        expect(res.body.hero.name).to.equal('Luke Cage');
      });
  })
});

import { strip } from '../src/routes/heroRouter'

//example single test
describe('#strip()', () => {
  it('should return a string stripped and lowered', () => {
    let name = 'Luke Cage';
    const result = strip(name);
    expect(result).to.equal('lukecage');
  });
});

//example multi data test
describe('#strip()', () => {
  let heroes = {
    'Luke Cage':'lukecage',
    'Wolverine':'wolverine',
    'Spider-Man':'spider-man'
  }
  //let nameTest = Object.keys(heroes);
  //nameTest.forEach((name) =>
  for (let name in heroes) {
    it(`should return ${name} striped and lowered, ${heroes[name]}`, () => {
      const result = strip(name);
      expect(result, `name=${name}`).to.equal(heroes[name]);
    })
  }
})
