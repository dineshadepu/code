"""Water rested in a vessel:: A Hydrostatic tank (30 minutes)

Check basic equations of SPH to throw a ball inside the vessel
"""
from __future__ import print_function
import numpy as np
import matplotlib.pyplot as plt

# PySPH base and carray imports
from pysph.base.utils import get_particle_array_wcsph
from pysph.base.kernels import CubicSpline

from pysph.solver.solver import Solver
from pysph.sph.integrator import EPECIntegrator
from pysph.sph.integrator_step import WCSPHStep

from pysph.sph.equation import Group
from pysph.sph.basic_equations import (
    XSPHCorrection,
    ContinuityEquation, )
from pysph.sph.wc.basic import TaitEOS, MomentumEquation
from pysph.solver.application import Application

from GeomSPH.geometry import get_tank, get_fluid, get_cube

dim = 3


def add_properties(pa, *props):
    for prop in props:
        pa.add_property(name=prop)


class FluidStructureInteration(Application):
    def initialize(self):
        self.dx = 2 * 1e-3
        self.hdx = 1.2
        self.ro = 1000
        self.co = 2 * np.sqrt(2 * 9.81 * 130 * 1e-3)
        self.alpha = 0.1

    def create_particles(self):
        # get both particle array positions
        # xf, yf, zf, xt, yt, zt = create_hydrostatic_tank(1, 1, 1, 0.01, 2)
        """Create the circular patch of fluid."""
        # xf, yf = create_fluid_with_solid_cube()

        tank1 = get_tank(length=140 * 1e-3, breadth=140 * 1e-3,
                         height=140 * 1e-3, spacing=4 * 1e-3, layers=2,
                         dim=dim)
        xt, yt, zt = tank1.get_xyz()
        ut = np.zeros_like(xt)
        vt = np.zeros_like(xt)
        wt = np.zeros_like(xt)
        m = np.ones_like(xt) * 1500 * tank1.spacing**dim
        rho = np.ones_like(xt) * 1000
        h = np.ones_like(xt) * self.hdx * tank1.spacing
        tank = get_particle_array_wcsph(x=xt, y=yt, z=zt, h=h, m=m, rho=rho,
                                        u=ut, v=vt, w=wt, name="tank")
        fluid1 = get_fluid(length=140 * 1e-3, breadth=140 * 1e-3,
                           height=100 * 1e-3, spacing=6 * 1e-3, dim=dim)
        fluid1.trim_tank(tank1)
        xf, yf, zf = fluid1.get_xyz()
        uf = np.zeros_like(xf)
        vf = np.zeros_like(xf)
        wf = np.zeros_like(xf)
        rho = np.ones_like(xf) * 1000
        m = np.ones_like(xf) * fluid1.spacing**dim * 1000
        h = np.ones_like(xf) * self.hdx * fluid1.spacing
        fluid = get_particle_array_wcsph(x=xf, y=yf, z=zf, h=h, m=m, rho=rho,
                                         u=uf, v=vf, w=wf, name="fluid")

        cube1 = get_cube(length=20 * 1e-3, breadth=20 * 1e-3, height=20*1e-3,
                         spacing=4 * 1e-3, left=(60 * 1e-3, 60 * 1e-3,
                                                 100*1e-3), dim=dim)
        xb, yb, zb = cube1.get_xyz()
        ub = np.zeros_like(xb)
        vb = np.zeros_like(xb)
        wb = np.zeros_like(xb)
        rho = np.ones_like(xb) * 1500
        m = np.ones_like(xb) * cube1.spacing**dim * 1500
        h = np.ones_like(xb) * self.hdx * cube1.spacing
        cube = get_particle_array_wcsph(x=xb, y=yb, z=zb, h=h, m=m, rho=rho,
                                        u=ub, v=vb, w=wb, name="cube")
        return [fluid, tank, cube]

    def create_solver(self):
        kernel = CubicSpline(dim=dim)

        integrator = EPECIntegrator(fluid=WCSPHStep(), tank=WCSPHStep())

        dt = 1e-4
        print("DT: %s" % dt)
        tf = 0.1
        solver = Solver(kernel=kernel, dim=dim, integrator=integrator, dt=dt,
                        tf=tf, adaptive_timestep=False)

        return solver

    def create_equations(self):
        equations = [
            Group(equations=[
                TaitEOS(dest='fluid', sources=None, rho0=self.ro, c0=self.co,
                        gamma=7.0),
                TaitEOS(dest='tank', sources=None, rho0=self.ro, c0=self.co,
                        gamma=7.0),
            ], real=False),
            Group(equations=[
                ContinuityEquation(
                    dest='fluid',
                    sources=['fluid', 'tank'], ),
                ContinuityEquation(
                    dest='tank',
                    sources=['fluid', 'tank'], ),
                MomentumEquation(dest='fluid', sources=['fluid', 'tank'],
                                 alpha=self.alpha, beta=0.0, c0=self.co,
                                 gz=-9.81),
                XSPHCorrection(dest='fluid', sources=['fluid', 'tank']),
            ]),
        ]
        return equations


if __name__ == '__main__':
    app = FluidStructureInteration()
    app.run()
    # x, y = create_fluid()
    # xt, yt = create_boundary(1 * 1e-3)
    # plt.scatter(xt, yt)
    # plt.scatter(x, y)
    # plt.axes().set_aspect('equal', 'datalim')
    # plt.show()
    # xt, yt = create_boundary(1 * 1e-3)
    # xc, yc, indices = create_cube()
    # xf, yf = create_fluid_with_solid_cube()
    # plt.scatter(xt, yt)
    # plt.scatter(xc, yc)
    # plt.scatter(xf, yf)
    # plt.axes().set_aspect('equal', 'datalim')
    # plt.show()
