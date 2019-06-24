from distutils.core import setup
from Cython.Build import cythonize

setup(ext_modules = cythonize("ClonalSelection.py"))
#setup(ext_modules = cythonize("BinaryDiffEvolution.py"))
#python setup.py build_ext --inplace

