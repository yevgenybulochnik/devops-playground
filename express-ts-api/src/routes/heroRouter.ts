import { Router, Request, Response, NextFunction } from 'express';
const Heroes = require('../data')

export class HeroRouter {
  router: Router

  constructor() {
    this.router = Router();
    this.init();
  }

  public getAll(req: Request, res: Response, next: NextFunction) {
    res.send(Heroes);
  }

  public getOne(req: Request, res: Response, next: NextFunction) {
    let query = parseInt(req.params.id);
    let hero = Heroes.find(hero => hero.id == query);
    if (hero) {
      res.status(200)
        .send({
          message: 'Success',
          status: res.status,
          hero
        });
    } else {
      res.status(404)
        .send({
          message: 'No hero found with given id',
          status: res.status
        })
    }
  }

  public getByName(req: Request, res: Response, next: NextFunction) {
    let query = req.params.name;
    let hero = Heroes.find(hero => strip(hero.name) == query)
    if (hero) {
      res.status(200)
        .send({
          message: 'Success',
          status: res.status,
          hero
        });
    } else {
      res.status(400)
        .send({
          message: 'No hero found with given name',
          status: res.status
        });
    }
  }

  init() {
    this.router.get('/', this.getAll);
    this.router.get('/:id', this.getOne);
    this.router.get('/name/:name', this.getByName);
  }
}

export function strip(heroName: string): string {
    let hero = heroName.replace(/\s/g, '')
    return hero.toLowerCase()
  }

const heroRoutes = new HeroRouter();
heroRoutes.init();

export default heroRoutes.router;
