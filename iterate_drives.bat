@echo off

rem ----- incomplete -----
for %%c in (A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
  if exist %%c: (
    echo Drive %%c: exists.
  ) else (
    echo Drive %%c: doesn't exist.
  )
)