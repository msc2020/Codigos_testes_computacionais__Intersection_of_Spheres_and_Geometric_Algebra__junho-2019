(* ::Package:: *)

(* Set up the Package Context. *)

(* :Title: Clifford Algebra of a Euclidean Space. *)

(* :Summary:
       This file contains declarations for calculations with Clifford
       algebra of a n-dimensional vector space.  When loaded,
       vectors (and multivectors) must be given as linear combinations
       of a canonical (orthonormal basis) that are denoted by
       e[1],e[2],..,e[n].
     
       Examples:     The vector {1,2,0,-1} should be written as
                     e[1] + 2 e[2] - e[4].
                     
                     The multivector a + 5e1 + e123 is written as
                     a + 5 e[1] + e[1]e[2]e[3].
   
       With the exception of the function Dual[m,n], it is not
       neccesary to define the dimension of the vector space, it
       is calculated automatically by the function dimensions[ ].
       The signature of the bilinear form is set by 
       $SetSignature, if not specified, the default value is 20 *)

(* :Version 1.2 for Mathematica 5.0: October, 2007. *)

(* :History:
	First version (1996): J.L. Aragon and O. Caballero

	First revised version (1997): J.L. Aragon
        Changes:
		-MultivectorInverse.
                -Subscripted -> SubscriptBox
		-Aliases discarded
              New:
                -Format 
                -Palette
	Version 1.2 (2007): G. Aragon-Camarasa, J.L. Aragon, G. Aragon and M.A. Rodriguez
		New:
			-GADraw function.
			-Palette.
			-Improvement of GADraw function for Mathematica 6.0
			-Online Help

	Version 1.3 (Oct,2007): G. Aragon-Camarasa, J.L. Aragon, G. Aragon and M.A. Rodriguez
		New:
			-Updated GADraw function
			-Improvement of GADraw function for Mathematica 6.0
			-Projection error fixed
 *)


(* :References: 
	1. D. Hestenes, 1987. New Foundations for Classical Mechanics. 
	   D. Reidel Publishing Co. Holland  
	2. S. Gull, A. Lasenby and C. Doran, 1993.
	   Imaginary Numbers are not Real- The Geometric Algebra of Spacetime.
	   Foundations of Physics, Vol. 23, No. 9: 1175-1201.
	3. T. Wickham-Jones, 1994. Mathematica Graphics: Techniques and Applications.
	   Springer-Verlag New York Inc.; Har/Dsk edition (Dec 1994). *)
	   

BeginPackage["Clifford`"]


(* Usage message for the exported function and the Context itself *)

Clifford::usage = "Clifford.m is a package to resolve operations with
Clifford Algebra."

e::usage = "e is used to denote the elements of the canonical basis of Euclidean vector
space where the Clifford Algebra is defined, so e[i] is used as i-th basis
element"

i::usage = "i represents the first component of a quaternion. i^2=-1"

j::usage = "j represents the second component of a quaternion. j^2=-1 "

k::usage = "k represents the third component of a quaternion. k^2=-1 "

GeometricProduct::usage = "GeometricProduct[m1,m2,...] calculates the Geometric
Product of multivectors m1,m2,..."

Coeff::usage = "Coeff[m,b] gives the coefficient of the r-blade b in the multivector m."

Grade::usage = "Grade[m,r] gives the r-vector part of the multivector m."

HomogeneousQ::usage = "HomogeneousQ[x,r] gives True if x is a r-blade and False
otherwise."

Turn::usage = "Turn[m] gives the Reverse of the multivector m."

Magnitude::usage = "Magnitude[m] calculates the Magnitude of the multivector m."

Dual::usage = "Dual[m,n] calculates the Dual of the multivector m in a
n-dimensional space."

InnerProduct::usage = "InnerProduct[m1,m2,...] calculates the Inner Product of
multivectors m1,m2,..."

OuterProduct::usage = "OuterProduct[m1,m2,...] calculates the Outer Product of
multivectors m1,m2,..."

Rotation::usage = "Rotation[v,w,x,theta] Rotates the vector v by an angle theta
(in degrees), along the plane defined by w and x. The sense of the rotation
is from w to x. Default value of theta is the  angle between w and x."

MultivectorInverse::usage = "MultivectorInverse[m] gives the inverse of a
multivector m."

Reflection::usage = "Reflection[v,w,x] reflects the vector v by the plane
formed by the vectors w and x."

Projection::usage = "Projection[v,w] calculate the Projection of the vector v
on the subspace defined by the r-blade w."

Rejection::usage = "Rejection[v,w] calculate the Rejection of the vector v on
the subspace defined by the r-blade w."

ToBasis::usage = "ToBasis[x] Transform the vector x from {a,b,...} to the
standar form used in this Package: ae[1]+be[2]+...."

ToVector::usage ="ToVector[x,n] transform the n-dimensional vector x from
ae[1]+be[2]+... to the standar Mathematica form {a,b,...}. The defaul value of
n is the highest of all e[i]'s."

QuaternionProduct::usage = "QuaternionProduct[q1,q2,...] gives the product of
quaternions q1,q2,..."

QuaternionInverse::usage = "QuaternionInverse[q] finds the inverse of a
quaternion q."

QuaternionMagnitude::usage = "QuaternionMagnitude[q] gives the magnitude of
a quaternion q."

QuaternionConjugate::usage = "QuaternionConjugate[q] gives the conjugated of a
quaternion q."

Pseudoscalar::usage = "Pseudoscalar[n] gives the n-dimensional pseudoscalar."

GeometricPower::usage = "GeometricPower[m,n] calculates the Geometic Product of
a multivector m, n-times."

GeometricProductSeries::usage = "GeometricProductSeries[sym,m,n] calculates the
series of the function sym, of a multivector m up to a power n. Default value of n is 10."

GeometricExp::usage = "GeometricExp[m,n] calculates the series of the function
Exp, of a multivector m up to a power n. Default value of n is 10."

GeometricSin::usage = "GeometricSin[m,n] calculates the series of the function
Sin, of a multivector m up to a power n. Default value of n is 10."

GeometricCos::usage = "GeometricCos[m,n] calculates the series of the function
Cos, of a multivector m up to a power n. Default value of n is 10."

GeometricTan::usage = "GeometricTan[m,n] calculates the series of the function
Tan, of a multivector m up to a power n. Default value of n is 10."

$SetSignature::usage = "$SetSignature Set the signature of the bilinear form
used to define the Clifford Algebra. The default value is 20. Once changed,
it can be recovered by Clear[$SetSignature];."

GADraw::usage = "GADraw function plots vectors, bi-vectors and trivectors in the canonical
basis of Clifford Algebra. To change the view of the plot, it must be
used the ViewPoint function, e.g. Draw[x,ViewPoint->{0,1,0}]. Default
value of ViewPoint is {1.3,-2.4,2}";


(* Set the signature of the bilinear form *)
$SetSignature = 20


Begin["`Private`"]  (* Begin the Private Context *)


(* Unprotect functions Re, Im and Clear to define our rules *)
protected = Unprotect [Re, Im, Clear, Projection]


(* Error Messages *)
Clifford::messagevectors = "`1` function works only with vectors."
Clifford::messagedim = "Function works in three dimensions."
DrawBiVec::"Out of Dimension" = "Dimension must be less or equal to 3 dimension.";


(* Clear function *)
Clear[$SetSignature] := $SetSignature = 20

(* Output mimics standard mathematical notation *)
Format[e[x_]] := SubscriptBox[e, x] //DisplayForm

(* Begin Geometric Product Section *)
GeometricProduct[ _] := $Failed
GeometricProduct[m1_,m2_,m3__] := GeometricProduct[GeometricProduct[m1,m2],m3]			
GeometricProduct[m1_,m2_] := geoprod[Expand[m1],Expand[m2]] // Expand
geoprod[a_,y_] := a y /; FreeQ[a,e[_?Positive]]
geoprod[x_,a_] := a x /; FreeQ[a,e[_?Positive]]
geoprod[x_,y_] := Module[{
   p1=ntuple[x,Max[dimensions[x],dimensions[y]]],q=1,s,r={},r1={},
   p2=ntuple[y,Max[dimensions[x],dimensions[y]]]},
   s=Sum[p2[[m]]*p1[[n]],{m,Length[p1]-1},{n,m+1,Length[p2]}];
        r1=p1+p2;
          r=Mod[r1,2];
            Do[ If[r[[i]] == 1, q *= e[i]];
     If[r1[[i]] == 2, q *= bilinearform[e[i],e[i]]],{i,Length[r1]} ];
    (-1)^s*q ]
geoprod[a_ x_,y_] := a geoprod[x,y] /; FreeQ[a,e[_?Positive]]
geoprod[x_,a_ y_] := a geoprod[x,y] /; FreeQ[a,e[_?Positive]]
geoprod[x_,y_Plus] := Distribute[tmp[x,y],Plus] /. tmp->geoprod
geoprod[x_Plus,y_] := Distribute[tmp[x,y],Plus] /. tmp->geoprod
(* End of Geometric Product Section *)


(* Begin Grade Section *)
Grade[m_Plus,r_?NumberQ] := Distribute[tmp[m,r],Plus] /. tmp->Grade
Grade[m_,r_?NumberQ] := If[grados[m]==r,m,0]
grados[a_] := 0 /; FreeQ[a,e[_?Positive]]
grados[x_] := grados[x] = Plus @@ ntuple[x,Max[dimensions[x]]]
grados[a_ x_] := grados[x] /; FreeQ[a,e[_?Positive]]
(* End of Grade Section *)


(* Begin Inner Product Section *)
InnerProduct[ _] := $Failed
InnerProduct[m1_,m2_,m3__] := InnerProduct[InnerProduct[m1,m2],m3]
InnerProduct[m1_,m2_] := innprod[Expand[m1],Expand[m2]] // Expand
innprod[a_,y_] := 0 /; FreeQ[a,e[_?Positive]]
innprod[x_,a_] := 0 /; FreeQ[a,e[_?Positive]]
innprod[x_,y_] := innprod[x,y] = Module[
      {p=Plus @@ ntuple[x,Max[dimensions[x],dimensions[y]]],
  q=Plus @@ ntuple[y,Max[dimensions[x],dimensions[y]]]},
  Grade[GeometricProduct[x,y],Abs[p-q]] ]
innprod[a_ x_,y_] := a innprod[x,y] /; FreeQ[a,e[_?Positive]]
innprod[x_,a_ y_] := a innprod[x,y] /; FreeQ[a,e[_?Positive]]
innprod[x_,y_Plus] := Distribute[tmp[x,y],Plus] /. tmp->innprod
innprod[x_Plus,y_] := Distribute[tmp[x,y],Plus] /. tmp->innprod
(* End of Inner Product Section *)


(* Begin Outer Product Section *)
OuterProduct[ _] := $Failed
OuterProduct[m1_,m2_,m3__] := OuterProduct[OuterProduct[m1,m2],m3]
OuterProduct[m1_,m2_] := outprod[Expand[m1],Expand[m2]] // Expand
outprod[a_,y_] := a y /; FreeQ[a,e[_?Positive]]
outprod[x_,a_] := a x /; FreeQ[a,e[_?Positive]]
outprod[x_,y_] := outprod[x,y] = Module[
      {p=Plus @@ ntuple[x,Max[dimensions[x],dimensions[y]]],
  q=Plus @@ ntuple[y,Max[dimensions[x],dimensions[y]]]},
  Grade[GeometricProduct[x,y],p+q] ]
outprod[a_ x_,y_] := a outprod[x,y] /; FreeQ[a,e[_?Positive]]
outprod[x_,a_ y_] := a outprod[x,y] /; FreeQ[a,e[_?Positive]]
outprod[x_,y_Plus] := Distribute[tmp[x,y],Plus] /. tmp->outprod
outprod[x_Plus,y_] := Distribute[tmp[x,y],Plus] /. tmp->outprod
(* End of Outer Product Section *)


(* Begin Turn Section *)
Turn[m_] := backside[Expand[m]]
backside[a_] := a /; FreeQ[a,e[_?Positive]]
backside[x_] := x /; Length[x]==1
backside[x_] := bakside[x] = GeometricProduct @@ e/@Reverse[dimensions[x]]
backside[a_ x_] := a backside[x] /; FreeQ[a,e[_?Positive]]
backside[x_Plus] := Distribute[tmp[x],Plus] /. tmp->backside
(* End of Turn Section *)


(* Pseudoscalar function *)
Pseudoscalar[x_?Positive] := Apply[Times, e /@ Range[x]]


(* HomogeneousQ function *)
HomogeneousQ[x_,r_?NumberQ] := SameQ[Expand[x],Expand[Grade[x,r]]]


(*  Magnitude function *)
Magnitude[v_] := Sqrt[Grade[GeometricProduct[v,Turn[v]],0]]


(* Dual function *)
Dual[v_,x_?Positive] := GeometricProduct[v,Turn[Pseudoscalar[x]]]


(* Begin Rotation function *)
Rotation[v_,w_,x_,angle_:Automatic] := Module[{r,theta=angle*Pi/180,
       plano=OuterProduct[w,x]},
       If[(!HomogeneousQ[v,1]) || (!HomogeneousQ[w,1]) || (!HomogeneousQ[x,1]),
           Message[Clifford::messagevectors,Rotation]; $Failed,
    If[angle === Automatic,
            theta=InnerProduct[w,x]/(Magnitude[w]*Magnitude[x]);
              r=Sqrt[(1+theta)/2]+Sqrt[(1-theta)/2]*plano/Magnitude[plano],
              r=Cos[theta/2]+Sin[theta/2]*plano/Magnitude[plano]];
    GeometricProduct[Turn[r],v,r]  ] ]
(* End of Rotation *)


(* Begin MultivectorInverse function *)
MultivectorInverse[v_] := Module[{v1=GeometricProduct[v,Turn[v]]},
             If[v1 === Grade[v1,0],
                Turn[v] / Magnitude[v]^2,
                Return[ StringForm["MultivectorInverse[``]", InputForm[v] ] ]
               ]
         ]
(* End of MultivectorInverse *)


(* Begin Reflection function *)
Reflection[v_,w_,x_] := Module[{u,plano=OuterProduct[w,x]},
      If[(!HomogeneousQ[v,1]) || (!HomogeneousQ[w,1]) || (!HomogeneousQ[x,1]),
           Message[Clifford::messagevectors,Reflection]; $Failed,
          u=Dual[plano/Magnitude[plano],3];
       GeometricProduct[-u,v,u] ] ]
(* End of Reflection *)


(* Projection function *)
Projection[v_,w_] := GeometricProduct[InnerProduct[v,w],MultivectorInverse[w]]


(* Rejection function *)
Rejection[v_,w_] := GeometricProduct[OuterProduct[v,w],MultivectorInverse[w]]


(* ToBasis function *)
ToBasis[x_?VectorQ] := Dot[x, List @@ e /@ Range[Length[x]]]


(* Begin  ToVector funtion *)
ToVector[x_,d_:Automatic] := Module[{dim=d,aux,v=Expand[x]},
   If[HomogeneousQ[v,1],
           aux=Flatten[dimensions[v]];
             If[d === Automatic, dim=Max[aux]];
              Table[ Coefficient[v, e[k]], {k,dim}],
     Message[Clifford::messagevectors,ToVector]; $Failed ] ]
(* End of ToVector *)


(* Coeff function *)
Coeff[x_,y_] := Grade[Coefficient[Expand[x],y],0]


(* Re function *)
Re[m_] := Grade[transform[Expand[m]],0]


(* Im function *)
Im[x_] := {Coefficient[x,i], Coefficient[x,j], Coefficient[x,k]}


(* Begin QuaternionProduct function *)
QuaternionProduct[ _] := $Failed
QuaternionProduct[q1_,q2_,q3__] := QuaternionProduct[QuaternionProduct[q1,q2],q3]
QuaternionProduct[q1_,q2_] := untransform[
                  GeometricProduct[transform[q1],transform[q2]] ]
(* End of QuaternionProduct *)


(* QuaternionInverse function *)
QuaternionInverse[q_] := untransform[MultivectorInverse[transform[Expand[q]]]]


(* QuaternionMagnitude function *)
QuaternionMagnitude[q_] := untransform[Magnitude[transform[Expand[q]]]]


(* QuaternionConjugate function *)
QuaternionConjugate[q_] := untransform[Turn[transform[Expand[q]]]]


(* Begin Geometric Power Section *)
GeometricPower[m_,n_Integer] := MultivectorInverse[GeometricPower[m,-n]] /;
          n < 0
GeometricPower[m_,0] := 1
GeometricPower[m_,n_Integer] := GeometricProduct[GeometricPower[m,n-1],m] /;
              n >= 1
(* End of Geometric Power *)


(* Geometric Exp function *)
GeometricExp[m_,n_:10] := GeometricProductSeries[Exp,m,n]


(* Geometric Sin function *)
GeometricSin[m_,n_:10] := GeometricProductSeries[Sin,m,n]


(* Geometric Cos function *)
GeometricCos[m_,n_:10] := GeometricProductSeries[Cos,m,n]


(* Geometric Tan function *)
GeometricTan[m_,n_:10] := GeometricProductSeries[Tan,m,n]


(* Begin Geometric Product Series function *)
GeometricProductSeries[sym_Symbol,m_,n_:10] := Module[
               {s=Series[sym[x],{x,0,n}],res=0,a=1},
           Do[If[i != 0, a=GeometricProduct[a,m]];
            res += Coefficient[s,x,i]*a, {i,0,n}];
               res     ] /; IntegerQ[n] && Positive[n]
(* End of Geometric Product Series *)


(* Begin bilinearform Section *)
bilinearform[e[i_],e[i_]] := 1 /; i <= $SetSignature
bilinearform[e[i_],e[i_]] := -1 /; i > $SetSignature


(* Begin dimensions Section *)
dimensions[x_Plus] := List @@ Distribute[tmp[x]] /. tmp->dimensions
dimensions[a_] := {0} /; FreeQ[a,e[_?Positive]]
dimensions[a_ x_] := dimensions[x] /; FreeQ[a,e[_?Positive]]
dimensions[x_] := dimensions[x] = List @@ x /. e[k_?Positive] -> k
(* End of dimensions Section *)


(* Begin ntuple function *)
ntuple[x_,dim_] := ntuple[x,dim] = ReplacePart[ Table[0,{dim}], 1, List @@ x /.
                                     e[k_?Positive] -> {k}]
(* End of ntuple *)


(* transform function *)
transform[x_] := x //. {i -> -e[2]e[3], j -> e[1]e[3], k -> -e[1]e[2]}


(* untransform function *)
untransform[x_] := x //. {e[2]e[3] -> -i, e[1]e[3] -> j, e[1]e[2] -> -k}

(* Added in May, 2007 *)
(* Draw functions *)

(* Begin GAarrow section
   This function generates the arrow of a vector *)

GAarrow[p_, color_] := Module[{sc,elms,cone,arrow,t,mat}, {
   (*Scale factor*)
   sc = Sqrt[p[[1]]^2 + p[[2]]^2 + p[[3]]^2]/2,
   (* The code for creating the cone was taken from the book Mathematica Graphics:
      Techniques and Applications."*)
   mat[1] = Sin[t]*(e[1]/14) + Cos[t]*(e[2]/14),
   mat[2] = Sin[t + 0.25]*(e[1]/14) + Cos[t + 0.25]*(e[2]/14), mat[3] = e[3]/5,
   (*Rotates, translates and create the cone*)
   If[OuterProduct[ToBasis[p],e[3]]===0,
       cone=Table[Array[ToVector[mat[#],3]&,3]+Array[p-ToVector[mat[3],3]&,3],{t,0.25,2*Pi,0.25}],
       elms=Array[sc*ToVector[Grade[Rotation[mat[#],e[3],ToBasis[p]],1],3]&,3];
       cone=Table[elms+Array[p-elms[[3]]&,3],{t,0.25,2*Pi,0.25}]], 
   (*Creates the 3D primitive graphic for the cone*)
   arrow = Graphics3D[{FaceForm[color], EdgeForm[], Polygon /@ cone},Lighting->Automatic]}; arrow]

(* Begin DrawVec section
   This function plots a tri-vector *)
DrawVec[x_] := Module[{points, graph, color, aux, arrow}, 
   {cc := Random[Real, {0, 1}], color = RGBColor[cc, cc, cc], 
     points = ToVector[x, 3], arrow = GAarrow[points, color], 
     aux = Graphics3D[{color, Line[{{0, 0, 0}, points}]
        }], graph = {{arrow, aux}}}; {graph, scalar}]

(* Begin DrawBiVec section
   This function plots a bi-vector *)
DrawBiVec[x_] := If[Length[x] > 3, Message[DrawBiVec::"Out of Dimension", x]; 
     $Failed, f]; 
DrawBiVec[x_] := Module[{xx, i, flag, s, t, pos, q, d, theta, rot1, rot2, 
    rot, r, graph, fac, h, t1, t2, w, cc}, 
   {cc := Random[Real, {-1, 1}], If[Head[x] === Plus, 
      {xx = x, For[i = 1, i <= Length[x], b[i] = x[[i]]; i++], 
       If[Length[x] == 3, flag = 1, flag = 0], For[i = 1, i <= Length[x], 
        {If[Length[b[i]] > 2, {scalar[i] = b[i][[1]], b[i] = Delete[b[i], 1], 
            c[i] = b[i] /. e[s_]*e[t_] -> {s, t}}, {scalar[i] = 1, 
            c[i] = b[i] /. e[s_]*e[t_] -> {s, t}}]}; i++], 
       If[c[1][[1]] === c[2][[1]], {pos = 1, q = {{1, 1, 0}, {-1, 1, 0}, 
           {-1, -1, 0}, {1, -1, 0}}}, pos = pos], If[c[1][[2]] === c[2][[1]], 
        {pos = 2, q = {{1, 1, 0}, {-1, 1, 0}, {-1, -1, 0}, {1, -1, 0}}}, 
        pos = pos], If[c[1][[2]] === c[2][[2]], 
        {pos = 3, q = {{1, 0, 1}, {-1, 0, 1}, {-1, 0, -1}, {1, 0, -1}}}, 
        pos = pos], d = Insert[{0, 0}, 1, pos], 
       theta = ArcTan[scalar[2]/scalar[1]], 
       fac = Sqrt[scalar[1]^2 + scalar[2]^2], 
       rot1 = {Cos[theta], -Sin[theta]}, rot2 = {Sin[theta], Cos[theta]}, 
       rot = Insert[{Insert[rot1, 0, pos], Insert[rot2, 0, pos]}, d, pos], 
       r = fac*q . rot, If[flag == 1, {theta = ArcTan[scalar[3]/fac]; 
          fac = Sqrt[fac^2 - scalar[3]^2]; rot = {{Cos[theta], -Sin[theta], 
             0}, {Sin[theta], Cos[theta], 0}, {0, 0, 1}}, r = fac*r . rot}, 
        r = r], graph = Graphics3D[{Polygon[r], Text[xx, {0, 0, 0}, 
           Background -> GrayLevel[1]]}]}, {xx = x, If[NumberQ[fac = x[[1]]], 
        w = Drop[x, 1], {w = x, fac = 1}], t1 = w[[1]] /. e[s_] -> s, 
       t2 = w[[2]] /. e[h_] -> h, If[t2 < 4, {If[t1 == 1 && t2 == 2, pos = 3, 
          Null], If[t1 == 2 && t2 == 3, pos = 1, Null], 
         If[t1 == 1 && t2 == 3, pos = 2, Null], fac = Abs[fac], 
         r = {fac*Insert[{1, 1}, 0, pos], fac*Insert[{-1, 1}, 0, pos], 
           fac*Insert[{-1, -1}, 0, pos], fac*Insert[{1, -1}, 0, pos]}, 
         graph = Graphics3D[{Polygon[r], Text[xx, {0, 0, 0}, 
             Background -> GrayLevel[1]]}]}]}]}; graph]

(* Begin DrawTriVec section
   This function plots a tri-vector *)
DrawTriVec[y_] := Module[{xx, x, fac, t, p, graph}, 
   {xx = x = y, x = List @@ Distribute[x], If[NumberQ[fac = x[[1]]], 
      x = Drop[x, 1], {x = x, fac = 1}], t = x[[3]] /. e[s_] -> s, 
     If[t < 4, {fac = Abs[fac], p = fac*{{-1, -1, -1}, {1, -1, -1}, 
          {1, 1, -1}, {-1, 1, -1}, {-1, -1, -1}, {-1, -1, 1}, {1, -1, 1}, 
          {1, 1, 1}, {-1, 1, 1}, {-1, -1, 1}, {1, -1, 1}, {1, -1, -1}, 
          {1, 1, -1}, {1, 1, 1}, {-1, 1, 1}, {-1, 1, -1}, {1, -1, 1}, 
          {1, -1, -1}, {-1, 1, 1}, {-1, -1, 1}, {1, 1, -1}, {1, 1, 1}, 
          {-1, -1, -1}}, graph = Graphics3D[{
          RGBColor[0, 0, 1], Line[p]}]}]}; graph]

(* Begin Draw section *)
GADraw[x_, v_:{ViewPoint -> {1.3, -2.4, 2}}] := 
  Module[{vec, bivec, graphvec, graphbivec, graph, msg},
  {msg = Grade[x, 0], vec = Grade[x, 1], bivec = Grade[x, 2], trivec = Grade[x, 3],
  If[vec === 0, If[bivec === 0, graph = graph, 
       {graphbivec = DrawBiVec[bivec], graph = {graphbivec}}], 
      If[bivec === 0, {graphvec = DrawVec[vec][[1]], graph = {graphvec}}, 
       {graphbivec = DrawBiVec[bivec], graphvec = DrawVec[vec][[1]], 
        graph = {graphvec, graphbivec}}]],
  If[trivec === 0, graph = graph, 
      {len = Length[graph], If[len > 0, graph = Append[graph, 
          DrawTriVec[trivec]], graph = DrawTriVec[trivec]]}], 
     eje1 = "\!\(e\_1\)", eje2 = "\!\(e\_2\)", eje3 = "\!\(e\_3\)", 
     ax = {eje1, eje2, eje3}, Null};
  Show[graph, Axes -> True, 
     AxesLabel -> ax, TextStyle -> {FontFamily -> "Times", FontSize -> 12}, 
     AxesEdge -> {{-1, -1}, {1, -1}, {-1, -1}}, (*ImageSize -> 300, *)
     PlotRange -> All, v, PlotLabel -> StyleForm[TraditionalForm[
       "Scalar = " <> ToString[msg]]]]]

Protect[Evaluate[protected]]   (* Restore protection of the functions *)


End[]  (* End the Private Context *)


(* Protect exported symbols *)

Protect[ GeometricProduct, Grade, Turn, Magnitude, Dual, InnerProduct,
         OuterProduct, Rotation, MultivectorInverse, Reflection, HomogeneousQ,
         Projection, Rejection, ToBasis, ToVector, QuaternionProduct,
         QuaternionInverse, QuaternionMagnitude, QuaternionConjugate,
         GeometricPower, GeometricProductSeries, GeometricExp, GeometricSin,
         GeometricCos, GeometricTan, Pseudoscalar, e, i, j, k, Coeff, GADraw
         ]


EndPackage[]  (* End the Package Context *)
