c programma principale per risoluzione carter con MESONI VETTORE
      implicit none
      integer m1,i,lck,nc,nv,ifail,j,k,ii,ncf,writ
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cu(lck),cv(lck),cs(lck),dcs(lck),
     & dcp(lck),cp(lck),sig,pion,a,b,rm,wf,rhof,as,at,das,dat,dpion,
     & u,v,s(m1),p(m1),en,lamu(lck),lamv(lck),
     & lams(lck),dlams(lck),lamp(lck),dlamp(lck),x,ss,pp,r(m1),
     & g,gw,grh,m,mr,mpi,mw,pi,fpi,dw,drho,
     & tlams(lck),dtlams(lck),tlamp(lck),dtlamp(lck),
     & cst(lck),dcst(lck),dcpt(lck),cpt(lck),alfa,hc,
     & entot,enpot,ensig,enpion,enraff,enrho,ena,enomega,
     & enqsig,enqpion,enqw,enqrho,enqa,
     & tlamw(lck),tlamr(lck),tlamas(lck),tlamat(lck),
     & cwt(lck),dcwt(lck),crt(lck),dcrt(lck),cast(lck),dcast(lck),
     & catt(lck),dcatt(lck),
     & dtlamw(lck),dtlamr(lck),dtlamas(lck),dtlamat(lck),
     & lamw(lck),dlamw(lck),lamr(lck),dlamr(lck),lamas(lck),lamat(lck),
     & cw(lck),dcw(lck),cr(lck),dcr(lck),cas(lck),dcas(lck),
     & cat(lck),dcat(lck),dlamas(lck),dlamat(lck),
     & onw,onr,ona,dsig,alfas,alfap,alfaw,alfar,alfaas,alfaat,
     & e1,bb,phi0,zpi,delta,s0,beta,
     & lam2,nu2,uzero,diffe,step,massasig,rmax,st,eig,bold

      common/grid/r
      common/range/a,b,rm
      common/rescale/bold
      common/constants/hc,pi


      common/masses/m,mpi,mr,mw
      common/couplings/g,gw,grh
      common/param/e1,bb,phi0,zpi,delta,fpi,s0,beta
      common/parmex/lam2,nu2,uzero

      common/accensione/onw,onr,ona


      common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv
      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat 

      common/temp/tlams,dtlams,tlamp,dtlamp,cst,dcst,dcpt,cpt
      common/tempvm/tlamw,dtlamw,tlamr,dtlamr,tlamas,dtlamas,tlamat,
     & dtlamat,cwt,dcwt,crt,dcrt,
     & cast,dcast,catt,dcatt

      common/ener/eig,entot,enpot,ensig,enpion,enraff,enrho,ena,enomega,
     & enqsig,enqpion,enqw,enqrho,enqa

      character*80 nfile1
      character*80 nfile2,nfile3,nfile4
      character*2 betastring,gwstring,gstring,grstring
      character*3 massastring
      character*4 rmaxstring
      character*1 dummy
      integer ibeta,imassa,irmax,ig,igw,igr
  
c     BOUNDARIES IN FM^-1

      a=1.d-5

      WRITE(6,620)
 620  FORMAT(1X,'INPUT RMAX IN FM ')
      READ(5,*)b
       write(*,*)'B = ',b
         rmax=b
         write(*,*)'RMAX = ',rmax
c      write(6,*)b

 
      rm=(a+b)/2.d0
c      rm=1.d0

      alfa=0.5d0
      alfas=0.5d0
      alfap=0.5d0
      alfaw=0.5d0
      alfar=0.5d0
      alfaas=0.5d0
      alfaat=0.5d0

      hc=197.3d0
      pi=4.0D0*DATAN(1.0D0)

C MASSES OF MESON FIELDS IN UNIT OF FM^-1

      m=550.d0/hc
c      m=650.d0/hc

      mpi=139.6d0/hc
      mr=770.d0/hc
      mw=782.d0/hc

C COUPLINGS TO FIELDS

c      WRITE(6,650)
c 650  FORMAT(1X,'G COUPLING CONSTANT')
c      READ(5,*)g
c      WRITE(6,630)
c 630  FORMAT(1X,'GW COUPLING CONSTANT')
c      READ(5,*)gw
c      WRITE(6,640)
c 640  FORMAT(1X,'GRHO COUPLING CONSTANT')
c      READ(5,*)grh

      g=5.d0
c      g=6.d0
      gw=12.d0

c      gw=11.d0
      grh=4.d0
c      grh=4.5d0
     
C PARAMETERS FOR LOGARITHMIC POTENTIAL

      fpi=93.d0/hc
      beta=1.d0
      zpi=1.d0/beta
      s0=fpi	
      e1=mpi**2*s0**2
c ms=550
c      bb=24.3672D0
c      phi0=0.88815D0
      bb=55.4273d0
      phi0=0.588881d0
c ms=600
c      bb=46.0702d0
c      phi0=0.64592d0
c ms=650
c      bb=38.9387d0
c      phi0=0.702584d0
c ms=800
c      bb=25.2854d0
c      phi0=0.871875d0
c ms=900
c      bb=19.8443d0
c      phi0=0.984172d0
c ms=950
c      bb=17.7691d0
c      phi0=1.04006d0
c ms=1200
c      bb=11.0451d0
c      phi0=1.31918d0
      delta=4.D0/33.D0      


C PARAMETERS FOR MEXICAN POTENTIAL

      lam2=(m**2-mpi**2)/(2.d0*fpi**2)
      nu2=fpi**2-mpi**2/lam2
      uzero=0.25d0*mpi**4/lam2-fpi**2*mpi**2


C PER ACCENDERE I CAMPI METTERE A 1, PER SPEGNERLI METTERE A ZERO:

      onw=0.d0
      onr=0.d0
      ona=0.d0
 

      call initial 

c      nc=1
c      do 10 i=1,m1
c         x=r(i)
c         write(*,*)x,wf(x),rhof(x),as(x),at(x)
c 10      continue
c         stop
     
      

      call dirac(en)
c      call relax(alfa)

      do 10 i=1,m1
         x=r(i)
         write(*,*)x,u(x),v(x)
 10      continue
c         stop

    
      call energy(en)
      write(*,*)'B = ',b,'---','N ITER = ',i,'---','EIGENVALUE = ',en*hc
      WRITE(*,*)'ENTOT = ',entot*hc,'-','ENRAFFELSKI = ',enraff*hc,
     & '----',(entot-enraff)*hc
      write(*,*)'ENSIG = ',ensig*hc,'-','ENPION = ',enpion*hc,'-',
     & 'ENPOT = ',enpot*hc
      write(*,*)'ENOMEGA = ',enomega*hc,'-','ENRHO = ',enrho*hc,
     & '-','EN.A = ',ena*hc
      write(*,*)'-----------------------------------'
      write(*,*)'EN.Q-SIG = ',enqsig*hc,'-','EN.Q-PION = ',enqpion*hc
      write(*,*)'EN.Q-OMEGA = ',enqw*hc,'-','EN.Q-RHO = ',enqrho*hc,
     & '-','EN.Q-A = ',enqa*hc

         









        




c
 200  write(*,*)'INIZIO FINITE DENSITY------------>'







       
C SCRITTURA SU FILE--------------------------------------------------- 
c      if (onw.eq.0.d0.or.ona.eq.0.d0.or.onr.eq.0.d0) then

      ibeta=nint(beta*10.d0)
      massasig=m*hc
      imassa=nint(massasig*1.d0)
      irmax=rmax*1000
      ig=nint(g*10.d0)
      igr=nint(grh*10.d0)
      igw=nint(gw*1.d0)
c      write(*,*)irmax
      write(betastring,'(i2)')ibeta
      write(massastring,'(i3)')imassa
      write(rmaxstring,'(i4)')irmax
      write(gstring,'(i2)')ig
      write(gwstring,'(i2)')igw
      write(grstring,'(i2)')igr
c      nfile1='campiBAND_logVMbeta'//betastring//'ms'//massastring//'g'
c     &//gstring//'gw'//gwstring//'gr'//grstring//
c     &'R'//rmaxstring//'findenRELAX.out'
 
      nfile3='EnergieBANDAvsR_logNOVMbeta'//betastring//'ms'
     & //massastring//'g'
     &//gstring//'gw'//gwstring//'gr'//grstring//
     &'findenRELAX.out'
c      nfile4='campiBANDansatzVM'//betastring//'ms'//massastring//'g'
c     &//gstring//'gw'//gwstring//'gr'//grstring//
c     &'R'//rmaxstring//'.out'
c      Print *,'scrivo su file:'
c      Print *, nfile1

      Print *,'scrivo su file:'
      Print *, nfile3
c      Print *,'scrivo su file:'
c      Print *, nfile4
c      open(2,file=nfile1,status='replace')
      open(3,file=nfile3,access='append',status='old')
c      open(4,file=nfile4,status='replace')
c      read(*,*)
c      else
c      nfile1='campi_logVMbeta'//betastring//'ms'//massastring//
c     & 'R'//rmaxstring//'finden.out'
c      nfile2='Energie_logVMbeta'//betastring//'ms'//massastring//
c     & 'R'//rmaxstring//'finden.out'
c      nfile3='EnergievsR_logNOVMbeta'//betastring//'ms'//massastring//
c     &'finden.out'
c      nfile4='campiansatz'//betastring//
c     &'R'//rmaxstring//'.out'
c      Print *,'scrivo su file:'
c      Print *, nfile1
c      Print *,'scrivo su file:'
c      Print *, nfile2
c      Print *,'scrivo su file:'
c      Print *, nfile3
c      Print *,'scrivo su file:'
c      Print *, nfile4
c      open(2,file=nfile1,status='replace')
c      open(1,file=nfile2,status='replace')
c      open(3,file=nfile3,access='append',status='replace')     
c      open(4,file=nfile4,status='replace')    
c      endif
c-------------------------------------------------------
      write(3,99)b,en*hc,entot*hc,enraff*hc,(entot-enraff)*hc,
     & ensig*hc,enpion*hc,enpot*hc,enomega*hc,enrho*hc,ena*hc,
     & enqsig*hc,enqpion*hc,enqw*hc,enqrho*hc,enqa*hc

c      r(1)=a
c      do 60 ii=1,m1
c         r(ii)=(dfloat(m1-ii)*a+dfloat(ii-1)*b)/dfloat(m1-1)
c 60     continue
c      r(m1)=b





      



      do 70 i=1,m1
        x=r(i)
c      write(2,99)x,u(x),v(x),sig(x),pion(x),wf(x),
c     & rhof(x),as(x),at(x)
c      write(4,99)x,u(x),v(x),sig(x),dsig(x),pion(x),dpion(x),
c     & wf(x),dw(x),rhof(x),drho(x),as(x),das(x),at(x),dat(x)
c        write(*,*)r(m1),u(b)
c     & rhof(x),as(x),at(x)
 70   continue


        write(*,*)b,r(m1),u(b)




 99   format(1x,16(1pe15.5))
      stop
      end

         

c_____________________________________________________________________________

      subroutine initial
      implicit none
      integer lck,i,m1,lwrk,ifail
      parameter (m1=401,lwrk=6*m1+16,lck=m1+4)
c      parameter (m1=1001,lwrk=6*m1+16,lck=m1+4)
      double precision cs(lck),dcs(lck),cp(lck),dcp(lck),x(m1),
     & paiinit,sigminit,dsigminit,dpaiinit,
     & uinit,vinit,ominit,dominit,rhoinit,drhoinit,
     & asinit,dasinit,atinit,datinit,
     & s(m1),p(m1),ds(m1),dp(m1),lams(lck),dlams(lck),lamp(lck),
     & dlamp(lck),wrk(lwrk),a,b,rm,pion,sig,u,v,uuu(m1),vvv(m1),
     & lamu(lck),cu(lck),lamv(lck),cv(lck),s1,xxx,
     & ssigg(m1),dds(m1),ppg(m1),dppg(m1),
     & tlams(lck),dtlams(lck),tlamp(lck),dtlamp(lck),
     & cst(lck),dcst(lck),dcpt(lck),cpt(lck),
     & uold(m1),unew(m1),vold(m1),vnew(m1),
     & tlamw(lck),tlamr(lck),tlamas(lck),tlamat(lck),
     & cwt(lck),dcwt(lck),crt(lck),dcrt(lck),cast(lck),dcast(lck),
     & catt(lck),dcatt(lck),
     & dtlamw(lck),dtlamr(lck),dtlamas(lck),dtlamat(lck),
     & ww(m1),dww(m1),rh(m1),drh(m1),asf(m1),dasf(m1),atf(m1),datf(m1),
     & lamw(lck),dlamw(lck),lamr(lck),dlamr(lck),lamas(lck),lamat(lck),
     & cw(lck),dcw(lck),cr(lck),dcr(lck),cas(lck),dcas(lck),
     & cat(lck),dcat(lck),dlamas(lck),dlamat(lck),
     & onw,onr,ona,
     & uunew(m1),vvnew(m1),sc(m1),dsc(m1),
     & pp(m1),dpp(m1),bold  ,
     & sold(m1),snew(m1),dsold(m1),dsnew(m1),
     & pold(m1),pnew(m1),dpold(m1),dpnew(m1),
     & wold(m1),wnew(m1),dwold(m1),dwnew(m1),
     & rold(m1),rnew(m1),drold(m1),drnew(m1),  
     & asold(m1),asnew(m1),dasold(m1),dasnew(m1),
     & atold(m1),atnew(m1),datold(m1),datnew(m1)

      common/grid/x     
      common/range/a,b,rm
      common/rescale/bold

      common/temp/tlams,dtlams,tlamp,dtlamp,cst,dcst,dcpt,cpt
      common/tempvm/tlamw,dtlamw,tlamr,dtlamr,tlamas,dtlamas,tlamat,
     & dtlamat,cwt,dcwt,crt,dcrt,
     & cast,dcast,catt,dcatt

      common/reldirac/uold,unew,vold,vnew
      common/relsig/sold,snew,dsold,dsnew
      common/relpion/pold,pnew,dpold,dpnew
      common/relomega/wold,wnew,dwold,dwnew
      common/relrho/rold,rnew,drold,drnew
      common/relas/asold,asnew,dasold,dasnew
      common/relat/atold,atnew,datold,datnew      

      common/accensione/onw,onr,ona

      common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv
      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat    

      write(*,*)'IN INITIAL'

     
c      open(10,file='MIOANSATZ4VM.out',status='old')
c      open(10,file='campi_ms550_LOGbeta13.out',status='old')
      open(10,file='campiansatzNOVM10ms550g50gw12gr40R1220.out'
     & ,status='old')

      do 80 i=1,m1
c         read(10,*)x(i),unew(i),vnew(i),s(i),ds(i),
c     & p(i),dp(i)
        read(10,*)x(i),unew(i),vnew(i),snew(i),dsnew(i),
     & pnew(i),dpnew(i),wnew(i),dwnew(i),rnew(i),drnew(i),
     & asnew(i),dasnew(i),atnew(i),datnew(i)
c         write(*,*)x(i),unew(i)
 80   continue  
    
   
     
c      stop



      ifail=0
      x(1)=a
      x(m1)=b
      bold=x(m1)
      do 20 i=2,m1-1
         x(i)=(dfloat(m1-i)*a+dfloat(i-1)*b)/dfloat(m1-1)
c         snew(i)=sigminit(x(i))
c         dsnew(i)=dsigminit(x(i))
c         pnew(i)=paiinit(x(i))
c         dpnew(i)=dpaiinit(x(i))
c         unew(i)=uinit(x(i))
c         vnew(i)=vinit(x(i))



c         ww(i)=ominit(x(i))
c         dww(i)=dominit(x(i))
c         rh(i)=rhoinit(x(i))
c         drh(i)=drhoinit(x(i))
c         asf(i)=asinit(x(i))
c         dasf(i)=dasinit(x(i))
c         atf(i)=atinit(x(i))
c         datf(i)=datinit(x(i))
c         write(*,*)x(i),s(i),ds(i)
 20      continue


     

c         snew(1)=sigminit(a)
c         dsnew(1)=dsigminit(a)        
c         pnew(1)=paiinit(a)
c         dpnew(1)=dpaiinit(a)
c         unew(1)=uinit(a)
c         vnew(1)=vinit(a)

c         ww(1)=ominit(a)
c         dww(1)=dominit(a)
c         rh(1)=rhoinit(a)
c         drh(1)=drhoinit(a)
c         asf(1)=asinit(a)
c         dasf(1)=dasinit(a)
c         atf(1)=atinit(a)
c         datf(1)=datinit(a)         

c         snew(m1)=sigminit(b)
c         dsnew(m1)=dsigminit(b)
c         pnew(m1)=paiinit(b) 
c         dpnew(m1)=dpaiinit(b)  
c         unew(m1)=uinit(b)
c         vnew(m1)=vinit(b)

c         ww(m1)=ominit(b)
c         dww(m1)=dominit(b)
c         rh(m1)=rhoinit(b)
c         drh(m1)=drhoinit(b)
c         asf(m1)=asinit(b)
c         dasf(m1)=dasinit(b)
c         atf(m1)=atinit(b)
c         datf(m1)=datinit(b) 

c         do 30 i=1,m1
c            write(*,*)x(i),s(i),ds(i)
c 30         continue
  
c         call e01baf(m1,x,s,tlams,cst,lck,wrk,lwrk,ifail)
c         call e01baf(m1,x,p,tlamp,cpt,lck,wrk,lwrk,ifail)   
  
         call e01baf(m1,x,snew,lams,cs,lck,wrk,lwrk,ifail)
         call e01baf(m1,x,pnew,lamp,cp,lck,wrk,lwrk,ifail)   

c         call e01baf(m1,x,ww,tlamw,cwt,lck,wrk,lwrk,ifail) 

         call e01baf(m1,x,wnew,lamw,cw,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,rnew,lamr,cr,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,atnew,lamat,cat,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,asnew,lamas,cas,lck,wrk,lwrk,ifail) 
 
c         call e01baf(m1,x,ds,dtlams,dcst,lck,wrk,lwrk,ifail)
c         call e01baf(m1,x,dp,dtlamp,dcpt,lck,wrk,lwrk,ifail) 

         call e01baf(m1,x,dsnew,dlams,dcs,lck,wrk,lwrk,ifail)
         call e01baf(m1,x,dpnew,dlamp,dcp,lck,wrk,lwrk,ifail) 



         call e01baf(m1,x,dwnew,dlamw,dcw,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,drnew,dlamr,dcr,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,datnew,dlamat,dcat,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,dasnew,dlamas,dcas,lck,wrk,lwrk,ifail) 
   
         call e01baf(m1,x,unew,lamu,cu,lck,wrk,lwrk,ifail)
         call e01baf(m1,x,vnew,lamv,cv,lck,wrk,lwrk,ifail) 


         return
         end
c-----------------------------------------------------------------
c_____________________________________________________________________________

      subroutine initdensity
      implicit none
      integer lck,i,m1,lwrk,ifail
      parameter (m1=401,lwrk=6*m1+16,lck=m1+4)
c      parameter (m1=1001,lwrk=6*m1+16,lck=m1+4)
      double precision cs(lck),dcs(lck),cp(lck),dcp(lck),x(m1),
     & paiinit,sigminit,dsigminit,dpaiinit,
     & uinit,vinit,ominit,dominit,rhoinit,drhoinit,
     & asinit,dasinit,atinit,datinit,
     & sd(m1),pd(m1),dsd(m1),dpd(m1),lams(lck),dlams(lck),lamp(lck),
     & dlamp(lck),wrk(lwrk),a,b,rm,pion,sig,u,v,uuu(m1),vvv(m1),
     & lamu(lck),cu(lck),lamv(lck),cv(lck),s1,xxx,
     & ssigg(m1),dds(m1),ppg(m1),dppg(m1),
     & tlams(lck),dtlams(lck),tlamp(lck),dtlamp(lck),
     & cst(lck),dcst(lck),dcpt(lck),cpt(lck),
     & uold(m1),unew(m1),vold(m1),vnew(m1),
     & tlamw(lck),tlamr(lck),tlamas(lck),tlamat(lck),
     & cwt(lck),dcwt(lck),crt(lck),dcrt(lck),cast(lck),dcast(lck),
     & catt(lck),dcatt(lck),
     & dtlamw(lck),dtlamr(lck),dtlamas(lck),dtlamat(lck),
     & wwd(m1),dwwd(m1),rhd(m1),drhd(m1),asfd(m1),dasfd(m1),atfd(m1),
     & datfd(m1),
     & lamw(lck),dlamw(lck),lamr(lck),dlamr(lck),lamas(lck),lamat(lck),
     & cw(lck),dcw(lck),cr(lck),dcr(lck),cas(lck),dcas(lck),
     & cat(lck),dcat(lck),dlamas(lck),dlamat(lck),
     & onw,onr,ona,    
     & wf,dw,dsig,dpion,rhof,drho,as,das,at,dat,bold,
     & sold(m1),snew(m1),dsold(m1),dsnew(m1),
     & pold(m1),pnew(m1),dpold(m1),dpnew(m1),  
     & wold(m1),wnew(m1),dwold(m1),dwnew(m1),         
     & rold(m1),rnew(m1),drold(m1),drnew(m1),
     & asold(m1),asnew(m1),dasold(m1),dasnew(m1),  
     & atold(m1),atnew(m1),datold(m1),datnew(m1)

      common/grid/x     
      common/range/a,b,rm
      common/rescale/bold

      common/temp/tlams,dtlams,tlamp,dtlamp,cst,dcst,dcpt,cpt
      common/tempvm/tlamw,dtlamw,tlamr,dtlamr,tlamas,dtlamas,tlamat,
     & dtlamat,cwt,dcwt,crt,dcrt,
     & cast,dcast,catt,dcatt

      common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv
      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat 

      common/reldirac/uold,unew,vold,vnew
      common/relsig/sold,snew,dsold,dsnew
      common/relpion/pold,pnew,dpold,dpnew
      common/relomega/wold,wnew,dwold,dwnew
      common/relrho/rold,rnew,drold,drnew
      common/relas/asold,asnew,dasold,dasnew
      common/relat/atold,atnew,datold,datnew

      common/accensione/onw,onr,ona

   


     






      ifail=0
      x(1)=a

      do 20 i=1,m1
         x(i)=(dfloat(m1-i)*a+dfloat(i-1)*b)/dfloat(m1-1)
c         sd(i)=sig(x(i))
c         dsd(i)=dsig(x(i))
c         pd(i)=pion(x(i))
c         dpd(i)=dpion(x(i))

         snew(i)=sig(x(i))
         dsnew(i)=dsig(x(i))
         pnew(i)=pion(x(i))
         dpnew(i)=dpion(x(i))
         unew(i)=u(x(i))
         vnew(i)=v(x(i))
c         wwd(i)=wf(x(i))
c         dwwd(i)=dw(x(i))

         wnew(i)=wf(x(i))
         dwnew(i)=dw(x(i))
         rnew(i)=rhof(x(i))
         drnew(i)=drho(x(i))
         asnew(i)=as(x(i))
         dasnew(i)=das(x(i))
         atnew(i)=at(x(i))
         datnew(i)=dat(x(i))
c         write(*,*)x(i),s(i),ds(i)
 20      continue
      x(m1)=b
      bold=x(m1)
c         sd(1)=sig(a)
c         dsd(1)=dsig(a)        
c         pd(1)=pion(a)
c         dpd(1)=dpion(a)

         snew(1)=sig(a)
         dsnew(1)=dsig(a)        
         pnew(1)=pion(a)
         dpnew(1)=dpion(a)
         unew(1)=u(a)
         vnew(1)=v(a)
         wnew(1)=wf(a)
         dwnew(1)=dw(a)
         rnew(1)=rhof(a)
         drnew(1)=drho(a)
         asnew(1)=as(a)
         dasnew(1)=das(a)
         atnew(1)=at(a)
         datnew(1)=dat(a)         

c         sd(m1)=sig(b)
c         dsd(m1)=dsig(b)
c         pd(m1)=pion(b) 
c         dpd(m1)=dpion(b)  

         snew(m1)=sig(b)
         dsnew(m1)=dsig(b)
         pnew(m1)=pion(b) 
         dpnew(m1)=dpion(b)  
         unew(m1)=u(b)
         vnew(m1)=v(b)
         wnew(m1)=wf(b)
         dwnew(m1)=dw(b)
         rnew(m1)=rhof(b)
         drnew(m1)=drho(b)
         asnew(m1)=as(b)
         dasnew(m1)=das(b)
         atnew(m1)=at(b)
         datnew(m1)=dat(b) 


c         call e01baf(m1,x,sd,tlams,cst,lck,wrk,lwrk,ifail)
c         call e01baf(m1,x,pd,tlamp,cpt,lck,wrk,lwrk,ifail)   

         call e01baf(m1,x,snew,lams,cs,lck,wrk,lwrk,ifail)
         call e01baf(m1,x,pnew,lamp,cp,lck,wrk,lwrk,ifail)   
         call e01baf(m1,x,wnew,lamw,cw,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,rnew,lamr,cr,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,atnew,lamat,cat,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,asnew,lamas,cas,lck,wrk,lwrk,ifail) 
 
c         call e01baf(m1,x,dsd,dtlams,dcst,lck,wrk,lwrk,ifail)
c         call e01baf(m1,x,dpd,dtlamp,dcpt,lck,wrk,lwrk,ifail) 

         call e01baf(m1,x,dsnew,dlams,dcs,lck,wrk,lwrk,ifail)
         call e01baf(m1,x,dpnew,dlamp,dcp,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,dwnew,dlamw,dcw,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,drnew,dlamr,dcr,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,datnew,dlamat,dcat,lck,wrk,lwrk,ifail) 
         call e01baf(m1,x,dasnew,dlamas,dcas,lck,wrk,lwrk,ifail) 
   




         return
         end
c-----------------------------------------------------------------

c-----------------------------------------------------------------
c CALCOLO ENERGIA 
      subroutine energy(en)
      implicit none
      integer m1,i,lck,nc,ifail,j
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cu(lck),cv(lck),cs(lck),dcs(lck),
     & dcp(lck),cp(lck),sig,pion,a,b,rm,dsig,dpion,
     & wf,dw,rhof,drho,as,at,das,dat,
     & u,v,s(m1),p(m1),en,lamu(lck),lamv(lck),
     & lams(lck),dlams(lck),lamp(lck),dlamp(lck),x,ss,pp,r(m1),
     & tlams(lck),dtlams(lck),tlamp(lck),dtlamp(lck),
     & cst(lck),dcst(lck),dcpt(lck),cpt(lck),alfa,
     & entot,denpot(m1),densig(m1),densig1(m1),densig2(m1),
     & denpion(m1),denraff(m1),
     & denomega(m1),denrho(m1),dena(m1),denkinq(m1), 
     & potzero,derslog(m1),derplog(m1),er,
     & enpot,ensig,enpion,enraff,pot,encinq,
     & enomega,enrho,ena,beta,ensig1,ensig2, 
     & denpot1(m1),denpot2(m1),denpot3(m1),
     & denqsig(m1),enqsig,denqpion(m1),enqpion,
     & denqw(m1),enqw,denqrho(m1),enqrho,
     & denqa(m1),enqa,
     & enpot1,enpot2,enpot3,gw,grh,mr,mw,ga,
     & g,m,hc,pi,e1,bb,phi0,zpi,delta,fpi,s0,mpi,
     & lamw(lck),dlamw(lck),lamr(lck),dlamr(lck),lamas(lck),lamat(lck),
     & cw(lck),dcw(lck),cr(lck),dcr(lck),cas(lck),dcas(lck),
     & cat(lck),dcat(lck),dlamas(lck),dlamat(lck),
     & onw,onr,ona,check(m1),
     & denraff1(m1),denraff2(m1),denraff3(m1),denraff4(m1),
     & enraff1,enraff2,enraff3,enraff4,eig

      common/grid/r
      common/range/a,b,rm

      common/param/e1,bb,phi0,zpi,delta,fpi,s0,beta
      common/couplings/g,gw,grh
      common/masses/m,mpi,mr,mw
      common/constants/hc,pi
 

      common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv
      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat 
      common/temp/tlams,dtlams,tlamp,dtlamp,cst,dcst,dcpt,cpt

      common/ener/eig,entot,enpot,ensig,enpion,enraff,enrho,ena,enomega,
     & enqsig,enqpion,enqw,enqrho,enqa

      common/accensione/onw,onr,ona


      do 20 i=1,m1
         denpot(i)=0.d0
         densig(i)=0.d0
         denpion(i)=0.d0
         denomega(i)=0.d0
         denrho(i)=0.d0
         dena(i)=0.d0
         denraff(i)=0.d0
         derslog(i)=0.d0
         derplog(i)=0.d0
         denqsig(i)=0.d0
         denqpion(i)=0.d0
         denqw(i)=0.d0
         denqrho(i)=0.d0
         denqa(i)=0.d0
         ensig=0.d0
         enpion=0.d0
         enomega=0.d0
         enrho=0.d0
         ena=0.d0
         enpot=0.d0
         enraff=0.d0
         enqsig=0.d0
         enqpion=0.d0
         enqw=0.d0
         enqrho=0.d0
         enqa=0.d0

 20      continue
      

   
      do 10 i=1,m1
      potzero=0.25d0*bb*phi0**4*(delta-1.d0)-e1




      denpot1(i)=-0.5d0*bb*delta*phi0**4*dlog((sig(r(i))**2+
     &pion(r(i))**2)/s0**2)
      
      denpot2(i)=0.5d0*bb*delta*(phi0**4/s0**2)*(sig(r(i))**2+
     & pion(r(i))**2-0.5d0*s0**2)

      denpot3(i)=-0.25d0*e1*(4.d0*sig(r(i))/s0-(2.d0/s0**2)*
     & (sig(r(i))**2+ pion(r(i))**2)+2.d0)

      denpot(i)=4.d0*pi*r(i)**2*(-0.25d0*bb*phi0**4+
     &  denpot1(i)+denpot2(i)+denpot3(i)-potzero)



c dalle mie
      densig(i)=4.d0*pi*r(i)**2*(0.5d0*beta*(-dsig(r(i))-
     & grh*pion(r(i))*
     & ona*(as(r(i))+2.d0*at(r(i))/3.d0))**2)




      denpion(i)=4.d0*pi*r(i)**2*(0.5d0*beta*(-dpion(r(i))+
     & grh*sig(r(i))*
     & ona*(as(r(i))+2.d0*at(r(i))/3.d0))**2+
     & beta*(-pion(r(i))/r(i)
     & +grh*pion(r(i))*onr*rhof(r(i))+grh*sig(r(i))*
     & ona*(as(r(i))-1.d0*at(r(i))/3.d0))**2)





      denomega(i)=onw*(4.d0*pi*r(i)**2*(-0.5d0*dw(r(i))**2-0.5d0*
     & mw**2*wf(r(i))**2))



      denrho(i)=4.d0*pi*r(i)**2*((onr*drho(r(i))+
     & 1.d0*onr*rhof(r(i))/r(i)-
     & grh*ona*(as(r(i))+2.d0*at(r(i))/3.d0)*ona*(as(r(i))-
     & 1.d0*at(r(i))/3.d0))**2+
     & 0.5d0*(2.d0*onr*rhof(r(i))/r(i)-grh*onr*rhof(r(i))**2-grh*ona*
     & (as(r(i))-1.d0*at(r(i))/3.d0)**2)**2+mr**2*onr*rhof(r(i))**2)







c METTENDO IL più NELLA SECONDA RIGA
      dena(i)=(4.d0*pi*r(i)**2*((ona*das(r(i))-1.d0*ona*dat(r(i))/3.d0-
     & 1.d0*ona*at(r(i))/r(i)+grh*onr*rhof(r(i))*(ona*as(r(i))+
     & 2.d0*ona*at(r(i))/3.d0))**2+
     & 0.5d0*mr**2*(3.d0*ona*as(r(i))**2+2.d0*ona*at(r(i))**2/3.d0)))






      derslog(i)=bb*delta*phi0**4*sig(r(i))*(1.d0/s0**2 -
     & 1.d0/(sig(r(i))**2+
     & pion(r(i))**2))+e1*(sig(r(i))-s0)/s0**2

      derplog(i)=bb*delta*phi0**4*pion(r(i))*(1.d0/s0**2 -
     & 1.d0/(pion(r(i))**2+
     & sig(r(i))**2))+e1*pion(r(i))/s0**2




       denraff1(i)=4.d0*pi*r(i)**2*(4.d0*(-0.25d0*bb*phi0**4+
     &  denpot1(i)+denpot2(i)+denpot3(i)-potzero)
     & -sig(r(i))*derslog(i)-pion(r(i))*derplog(i))

       denraff2(i)=4.d0*pi*r(i)**2*(-mw**2*onw*wf(r(i))**2)

       denraff3(i)=4.d0*pi*r(i)**2*(mr**2*onr*2.d0*rhof(r(i))**2)

       denraff4(i)=4.d0*pi*r(i)**2*(mr**2*ona*
     & (3.d0*as(r(i))**2+2.d0*at(r(i))**2/3.d0))

       denraff(i)=denraff1(i)+denraff2(i)+denraff3(i)+
     & denraff4(i)


       denqsig(i)=4.d0*pi*r(i)**2*((3.d0/(4.d0*pi))*
     & g*sig(r(i))*(u(r(i))**2-v(r(i))**2))

       denqpion(i)=4.d0*pi*r(i)**2*((3.d0/(4.d0*pi))*
     & 2.d0*g*u(r(i))*v(r(i))*pion(r(i)))

       denqw(i)=4.d0*pi*r(i)**2*((3.d0/(4.d0*pi))*
     & gw*wf(r(i))*(u(r(i))**2+v(r(i))**2)/3.d0)

       denqrho(i)=4.d0*pi*r(i)**2*(-(3.d0/(4.d0*pi))*
     & 2.d0*grh*u(r(i))*v(r(i))*rhof(r(i)))

       denqa(i)=4.d0*pi*r(i)**2*(-(3.d0/(4.d0*pi))*
     & (grh*(1.5d0*as(r(i))*(u(r(i))**2-1.d0*v(r(i))**2/3.d0)+
     & 2.d0*at(r(i))*v(r(i))**2/3.d0)))


       check(i)=das(r(i))+2.d0*dat(r(i))/3.d0+
     & 2.d0*at(r(i))/r(i)-grh*s0*pion(r(i))*mr**2/mpi**2

C       write(*,*)'CHECK CAMPI A ', check(i)

 10       continue
          ifail=0
       call d01gaf(r,denpot1,m1,enpot1,er,ifail)
       call d01gaf(r,denpot2,m1,enpot2,er,ifail)
       call d01gaf(r,denpot3,m1,enpot3,er,ifail)
c       write(*,*)'check energia potenziale---',enpot1,
c     & enpot2,enpot3,potzero

       call d01gaf(r,denraff1,m1,enraff1,er,ifail)
       call d01gaf(r,denraff2,m1,enraff2,er,ifail)
       call d01gaf(r,denraff3,m1,enraff3,er,ifail)
       call d01gaf(r,denraff4,m1,enraff4,er,ifail)




       call d01gaf(r,denpot,m1,enpot,er,ifail)
       call d01gaf(r,densig,m1,ensig,er,ifail)
       call d01gaf(r,denpion,m1,enpion,er,ifail)
       call d01gaf(r,denomega,m1,enomega,er,ifail)
       call d01gaf(r,denrho,m1,enrho,er,ifail)
       call d01gaf(r,dena,m1,ena,er,ifail)
       call d01gaf(r,denraff,m1,enraff,er,ifail)

       call d01gaf(r,denqsig,m1,enqsig,er,ifail)
       call d01gaf(r,denqpion,m1,enqpion,er,ifail)
       call d01gaf(r,denqw,m1,enqw,er,ifail)
       call d01gaf(r,denqrho,m1,enqrho,er,ifail)
       call d01gaf(r,denqa,m1,enqa,er,ifail)

c       write(*,*)enraff1*hc,enraff2*hc,enraff3*hc,enraff4*hc,
c     & enraff*hc
c       write(*,*)enpot*hc,enraff*hc
c       write(*,*)enpot*hc,ensig*hc,enpion*hc,
c     & enraff*hc
       entot=3*en+enpot+ensig+enpion+onw*enomega+onr*enrho+
     &   ona*ena
c       write(*,*)'ENERGIA A-------------->',ena*hc
       return
       end


c------------------------------------------------------------------
C DIRAC.F---------------->RISOLVE L'EQUAZIONE DI DIRAC
      subroutine dirac(en)
      implicit none
      integer n,n1,m1, ifail,i,j
      integer lck,lwrk
      parameter (n=2,n1=2,m1=401,lck=m1+4,lwrk=6*m1+16)
c      parameter (n=2,n1=2,m1=1001,lck=m1+4,lwrk=6*m1+16)
      double precision h,e(n),parerr(n1),param(n1),
     & c(m1,n),mat(m1,n1),copy(1,1),wspace(n,9),wspac1(n),
     & wspac2(n),g,ga,hc,a,b,rm,dum(m1),x,x1,r,x0,ud(m1),vd(m1),
     & norm,er,yy(m1),lamu(lck),cu(lck),cv(lck),lamv(lck),wrk(lwrk),
     & cs(lck),lams(lck),dlams(lck),dcs(lck),cp(lck),lamp(lck),
     & dlamp(lck),dcp(lck),en,xxx,sig,pion,wf,rhof,as,at,
     & uold(m1),unew(m1),vold(m1),vnew(m1),gw,grh,
     & tlamw(lck),tlamr(lck),tlamas(lck),tlamat(lck),
     & cwt(lck),dcwt(lck),crt(lck),dcrt(lck),cast(lck),dcast(lck),
     & catt(lck),dcatt(lck),pi,
     & dtlamw(lck),dtlamr(lck),dtlamas(lck),dtlamat(lck),
     & lamw(lck),dlamw(lck),lamr(lck),dlamr(lck),lamas(lck),lamat(lck),
     & cw(lck),dcw(lck),cr(lck),dcr(lck),cas(lck),dcas(lck),
     & cat(lck),dcat(lck),dlamas(lck),dlamat(lck),
     & onw,onr,ona,entot,enpot,ensig,enpion,enraff,enrho,ena,enomega,
     & enqsig,enqpion,enqw,enqrho,enqa,eig,ua,va,ub,vb

      external aux,bcaux,raux,prsol


      common/grid/dum 
      common/range/a,b,rm
      common/couplings/g,gw,grh
      common/constants/hc,pi

      common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv
      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat 

      common/reldirac/uold,unew,vold,vnew
      
      common/ener/eig,entot,enpot,ensig,enpion,enraff,enrho,ena,enomega,
     & enqsig,enqpion,enqw,enqrho,enqa

      common/accensione/onw,onr,ona 

      common/condizioni/ua,va,ub,vb

c      do 60 i=1,m1
c         uold(i)=unew(i)
c         vold(i)=vnew(i)
c 60      continue
 
      a=dum(1)
      b=dum(m1)

    

      eig=en

      
      ifail=0


   

      write(*,*)'IN DIRAC_____________',b,uold(m1),eig*hc,en*hc

      h=1.d-3
      e(1)=1.d-12
      e(2)=1.d-12
      parerr(1)=1.d-12
      parerr(2)=1.d-12

c      param(1)=vb
c      param(2)=en

      param(1)=0.5d0
      param(2)=0.5d0
  


      call d02agf(h,e,parerr,param,c,n,n1,m1,aux,bcaux,raux,
     & prsol,mat,copy,wspace,wspac1,wspac2,ifail)


      write(*,*)'u(a)= ',ua,'--','v(a)= ',va,'--',
     & 'u(b)=',ub,'--','v(b)= ',vb
            DO 20 I = 1, m1
                unew(i)=c(i,1)
                vnew(i)=c(i,2)
                yy(i)=dum(i)**2*(unew(i)**2+vnew(i)**2)
   20       CONTINUE

            call d01gaf(dum,yy,m1,norm,er,ifail)
c            write(*,*)'NORMA QUARKI= ',norm
            DO 30 I = 1, m1
                unew(i)=unew(i)/dsqrt(norm)
                vnew(i)=vnew(i)/dsqrt(norm)
                write(*,*)i,unew(i),vnew(i)
   30       CONTINUE            

            write(*,*)'UNEW(M1)=',unew(m1)
      en=param(2)
      eig=en
c      write(*,*)'eigenvalue-------->',en*hc

      ifail=1
      call e01baf(m1,dum,unew,lamu,cu,lck,wrk,lwrk,ifail)
      call e01baf(m1,dum,vnew,lamv,cv,lck,wrk,lwrk,ifail)      
      ifail=0
 

99999 FORMAT (1X,A,I5)
99998 FORMAT (1X,2E16.6)
99997 FORMAT (1X,3E16.6)


      return
      end
c_______________________________________________________________________

      subroutine aux(f,y,x,param)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
      double precision f(2),y(2),x ,param(2),g,hc,
     & pp,ss,cs(lck),lams(lck),cp(lck),lamp(lck),
     & lamu(lck),lamv(lck),cu(lck),cv(lck),sig,pion,
     & dlams(lck),dcs(lck),dlamp(lck),dcp(lck),pi,
     & tlamw(lck),tlamr(lck),tlamas(lck),tlamat(lck),
     & cwt(lck),dcwt(lck),crt(lck),dcrt(lck),cast(lck),dcast(lck),
     & catt(lck),dcatt(lck),gw,grh,ga,rhof,wf,as,at,
     & dtlamw(lck),dtlamr(lck),dtlamas(lck),dtlamat(lck),
     & lamw(lck),dlamw(lck),lamr(lck),dlamr(lck),lamas(lck),lamat(lck),
     & cw(lck),dcw(lck),cr(lck),dcr(lck),cas(lck),dcas(lck),
     & cat(lck),dcat(lck),dlamas(lck),dlamat(lck),
     & onw,onr,ona

      common/couplings/g,gw,grh
      common/constants/hc,pi

      common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv
      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat    

      common/accensione/onw,onr,ona 



c     y(1)=u,y(2)=v
     

      f(1)=(g*pion(x)-grh*onr*rhof(x))*y(1)+
     & (-g*sig(x)-param(2)+0.5d0*grh*ona*(as(x)-4.d0*at(x)/3.d0)+
     & (gw/3.d0)*onw*wf(x))*y(2)

      f(2)=-2.d0*y(2)/x+(-g*pion(x)+grh*onr*rhof(x))*y(2)+
     & (-g*sig(x)+param(2)+1.5d0*grh*ona*as(x)-(gw/3.d0)*onw*wf(x))*y(1)
      return
      end

c_______________________________________________________________________

      subroutine bcaux(g0,g1,param)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)

      double precision g0(2),g1(2),param(2),g,a,b,
     & rm,hc,pp,ss,cs(lck),lams(lck),cp(lck),lamp(lck),
     & lamu(lck),lamv(lck),cu(lck),cv(lck),sig,ga,
     & dlams(lck),dcs(lck),dlamp(lck),dcp(lck),gw,grh,
     & lamw(lck),dlamw(lck),lamr(lck),dlamr(lck),lamas(lck),lamat(lck),
     & cw(lck),dcw(lck),cr(lck),dcr(lck),cas(lck),dcas(lck),
     & cat(lck),dcat(lck),dlamas(lck),dlamat(lck),
     & c1,k1,as,at,pion,wf,rhof,onw,onr,ona,
     & ua,va,ub,vb 

      common/range/a,b,rm
      common/couplings/g,gw,grh

      common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv
      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat    

      common/accensione/onw,onr,ona 
      common/condizioni/ua,va,ub,vb

c      c1=-g*pion(b)+grh*onr*rhof(b)
      
c      c1=-g*pion(b)

c      k1=-g*sig(b)-param(2)+0.5d0*grh*ona*(as(b)-4.d0*at(b)/3.d0)+
c     & gw*onw*wf(b)/3.d0 
c      k1=(-g*sig(b)-param(2))

      g0(1)=3.d0

      g0(2)=(a/3.d0)*(param(1)+g*sig(a))*g0(1)
c      g1(1)=param(1)
      g1(1)=0.d0

      g1(2)=param(1)



      ua=g0(1)
      va=g0(2)

      ub=g1(1)
      vb=g1(2)
c condizioni come Mathematica
c      g1(2)=g1(1)*c1/k1

      return
      end

c_______________________________________________________________________

      subroutine raux(x0,x1,r,param)
      implicit none
      double precision x0,x1,r,param(2),a,b,rm

      common/range/a,b,rm
      
      x0=a
      x1=b
      r=rm

      return
      end
c_______________________________________________________________________

      subroutine prsol(param,res,n1,err)
      implicit none
      integer n1,iprint
      double precision param(n1),res,err(n1)

      iprint=1
      if (iprint.ne.0) then
         write(*,*)' PARAMETERS',param(1),param(2),err(1),err(2)
         endif
        
      return
      end
      
c_______________________________________________________________________


c -----------------------------------------------------------

      double precision function uinit(x)
      implicit none
      double precision x
      uinit=3.43778d0*dexp(-x**2/0.70889d0**2)
   
      return
      end

c -----------------------------------------------------------



      double precision function vinit(x)
      implicit none
      double precision x
      vinit=3.85909d0*x*dexp(-x**2/0.712113d0**2)
   
      return
      end


c -----------------------------------------------------------

      double precision function paiinit(x)
      implicit none
      double precision x

      paiinit=-0.646833d0*x*dexp(-25.1541d0*x**2/7.52812d0**2)/
     & (x**2+0.308042d0)

   
      return
      end

c -----------------------------------------------------------

      double precision function dpaiinit(x)
      implicit none
      double precision x,alp,be,delt,gam

      alp=0.646833d0
      be=25.1541d0
      delt=7.52812d0
      gam=0.308042d0

      dpaiinit=(alp*(delt**2*(-gam + x**2) + 2*be*x**2*(gam + x**2)))/
     &  (delt**2*dexp((be*x**2)/delt**2)*(gam + x**2)**2)
   
      return
      end
      

c-----------------------------------------------

      double precision function sigminit(x)
      implicit none
      double precision x,pi
      pi=4.0D0*DATAN(1.0D0)
      

      sigminit=-0.470236d0*dcos(pi*dtanh(1.1941d0*x))-
     & 0.238924d0*dexp(-x**2/0.901745d0**2)


 
      return
      end
c-----------------------------------------------

      double precision function dsigminit(x)
      implicit none
      double precision x,pi,alps,bes,ccs,delts

      pi=4.0D0*DATAN(1.0D0)
      alps=0.470236d0
      bes=1.1941d0
      ccs=0.238924d0
      delts=0.901745d0

      dsigminit=(2*ccs*x)/(delts**2*dexp(x**2/delts**2)) + 
     &  alps*bes*pi*(1.d0/dcosh(bes*x))**2*dsin(Pi*dtanh(bes*x))
 
      return
      end
c-----------------------------------------------

      double precision function ominit(x)
      implicit none
      double precision x,pi
      pi=4.0D0*DATAN(1.0D0)
      
      ominit=0.384535d0*dexp(-x**2/0.676873d0**2)

      return
      end
C_c-----------------------------------------------

      double precision function dominit(x)
      implicit none
      double precision x,pi,aw,bw
      pi=4.0D0*DATAN(1.0D0)
      aw=0.384535d0
      bw=0.676873d0
      
      dominit=-2.d0*aw*x*dexp(-x**2/bw**2)/bw**2

      return
      end
C-----------------------------------------------------


      double precision function asinit(x)
      implicit none
      double precision x,pi
      pi=4.0D0*DATAN(1.0D0)
      
      asinit=0.332267d0*dexp(-x**2/0.560751d0**2)

      return
      end
C_c-----------------------------------------------


      double precision function dasinit(x)
      implicit none
      double precision x,pi,aas,bas
      pi=4.0D0*DATAN(1.0D0)
      aas=0.332267d0
      bas=0.560751d0
      
      dasinit=-2.d0*aas*x*dexp(-x**2/bas**2)/bas**2

      return
      end
C-----------------------------------------------------


      double precision function rhoinit(x)
      implicit none
      double precision x

      rhoinit=0.261689d0*x*dexp(-1.39499d0*x**2/0.980598d0**2)/
     & (x**2+0.383631d0)

   
      return
      end

c -----------------------------------------------------------

      double precision function drhoinit(x)
      implicit none
      double precision x,alpr,ber,deltr,gamr

      alpr=0.261689d0
      ber=1.39499d0
      deltr=0.980598d0
      gamr=0.383631d0

      drhoinit=(alpr*(deltr**2*(-gamr+ x**2)+2*ber*x**2*(gamr + x**2)))/
     &  (deltr**2*dexp((ber*x**2)/deltr**2)*(gamr + x**2)**2)
   
      return
      end
      

c-----------------------------------------------


      double precision function atinit(x)
      implicit none
      double precision x

      atinit=0.463911d0*x*dexp(-0.310293d0*x**2/0.652699d0**2)/
     & (x**2+2.18632d0)

   
      return
      end

c -----------------------------------------------------------

      double precision function datinit(x)
      implicit none
      double precision x,alpat,beat,deltat,gamat

      alpat=0.463911d0
      beat=0.310293d0
      deltat=0.652699d0
      gamat=2.18632d0

      datinit=(alpat*(deltat**2*(-gamat + x**2) + 2*beat*x**2*
     & (gamat + x**2)))/
     &  (deltat**2*dexp((beat*x**2)/deltat**2)*(gamat + x**2)**2)
   
      return
      end
      

c-----------------------------------------------
c________________________________________________________________
c---------------------------------------------------
      double precision function sig(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cs(lck),lams(lck),cp(lck),lamp(lck),
     & lamu(lck),lamv(lck),cu(lck),cv(lck),xx,ssig,
     & dlams(lck),dcs(lck),dlamp(lck),dcp(lck)
      common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv
      


      ifail=1
      call e02bbf(m1+4,lams,cs,xx,ssig,ifail)
      ifail=0
      sig=ssig

      return
      end
c---------------------------------------------------
      double precision function dsig(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cs(lck),lams(lck),cp(lck),lamp(lck),
     & lamu(lck),lamv(lck),cu(lck),cv(lck),xx,dssig,
     & dlams(lck),dcs(lck),dlamp(lck),dcp(lck)      
      common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv

 


      ifail=1
      call e02bbf(m1+4,dlams,dcs,xx,dssig,ifail)
      ifail=0
      dsig=dssig

      return
      end

c -----------------------------------------------------------

      double precision function pion(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cs(lck),lams(lck),cp(lck),lamp(lck),
     & lamu(lck),lamv(lck),cu(lck),cv(lck),xx,ppion,
     & dlams(lck),dcs(lck),dlamp(lck),dcp(lck)  
      common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv



      ifail=1
      call e02bbf(m1+4,lamp,cp,xx,ppion,ifail)
      ifail=0
      pion=ppion

      return
      end
c -----------------------------------------------------------

      double precision function dpion(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cs(lck),lams(lck),cp(lck),lamp(lck),
     & lamu(lck),lamv(lck),cu(lck),cv(lck),xx,dppion,
     & dlams(lck),dcs(lck),dlamp(lck),dcp(lck)  
      common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv



      ifail=1
      call e02bbf(m1+4,dlamp,dcp,xx,dppion,ifail)
      ifail=0
      dpion=dppion

      return
      end
c -----------------------------------------------------------

      double precision function u(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cs(lck),lams(lck),cp(lck),lamp(lck),
     & lamu(lck),lamv(lck),cu(lck),cv(lck),xx,uuu,
     & dlams(lck),dcs(lck),dlamp(lck),dcp(lck)  
       common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv
   


      ifail=1
      call e02bbf(m1+4,lamu,cu,xx,uuu,ifail)
      ifail=0
      u=uuu

      return
      end

c -----------------------------------------------------------

      double precision function v(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cs(lck),lams(lck),cp(lck),lamp(lck),
     & lamu(lck),lamv(lck),cu(lck),cv(lck),xx,vvv,
     & dlams(lck),dcs(lck),dlamp(lck),dcp(lck)  
        common/lambdas/lams,dlams,lamp,dlamp,lamu,lamv,cs,
     & dcs,dcp,cp,cu,cv
   


      ifail=1
      call e02bbf(m1+4,lamv,cv,xx,vvv,ifail)
      ifail=0
      v=vvv
      return
      end
c---------------------------------------------------
      double precision function wf(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cw(lck),lamw(lck),cr(lck),lamr(lck),
     & lamas(lck),lamat(lck),cas(lck),cat(lck),xx,om,
     & dlamw(lck),dcw(lck),dlamr(lck),dcr(lck),dlamas(lck),
     & dcas(lck),dlamat(lck),dcat(lck)

      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat 
 
      


      ifail=1
      call e02bbf(m1+4,lamw,cw,xx,om,ifail)
      ifail=0
      wf=om

      return
      end
c---------------------------------------------------
      double precision function dw(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cw(lck),lamw(lck),cr(lck),lamr(lck),
     & lamas(lck),lamat(lck),cas(lck),cat(lck),xx,dom,
     & dlamw(lck),dcw(lck),dlamr(lck),dcr(lck),dlamas(lck),
     & dcas(lck),dlamat(lck),dcat(lck)

      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat 
 
      


      ifail=1
      call e02bbf(m1+4,dlamw,dcw,xx,dom,ifail)
      ifail=0
      dw=dom

      return
      end
c---------------------------------------------------
      double precision function rhof(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cw(lck),lamw(lck),cr(lck),lamr(lck),
     & lamas(lck),lamat(lck),cas(lck),cat(lck),xx,rhh,
     & dlamw(lck),dcw(lck),dlamr(lck),dcr(lck),dlamas(lck),
     & dcas(lck),dlamat(lck),dcat(lck)

      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat 
 
      


      ifail=1
      call e02bbf(m1+4,lamr,cr,xx,rhh,ifail)
      ifail=0
      rhof=rhh

      return
      end
c---------------------------------------------------
      double precision function drho(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cw(lck),lamw(lck),cr(lck),lamr(lck),
     & lamas(lck),lamat(lck),cas(lck),cat(lck),xx,drhh,
     & dlamw(lck),dcw(lck),dlamr(lck),dcr(lck),dlamas(lck),
     & dcas(lck),dlamat(lck),dcat(lck)

      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat 
 
      


      ifail=1
      call e02bbf(m1+4,dlamr,dcr,xx,drhh,ifail)
      ifail=0
      drho=drhh

      return
      end
c---------------------------------------------------
      double precision function as(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cw(lck),lamw(lck),cr(lck),lamr(lck),
     & lamas(lck),lamat(lck),cas(lck),cat(lck),xx,ass,
     & dlamw(lck),dcw(lck),dlamr(lck),dcr(lck),dlamas(lck),
     & dcas(lck),dlamat(lck),dcat(lck)

      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat 
 
      


      ifail=1
      call e02bbf(m1+4,lamas,cas,xx,ass,ifail)
      ifail=0
      as=ass

      return
      end
c---------------------------------------------------   
      double precision function das(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cw(lck),lamw(lck),cr(lck),lamr(lck),
     & lamas(lck),lamat(lck),cas(lck),cat(lck),xx,dass,
     & dlamw(lck),dcw(lck),dlamr(lck),dcr(lck),dlamas(lck),
     & dcas(lck),dlamat(lck),dcat(lck)

      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat 
 
      


      ifail=1
      call e02bbf(m1+4,dlamas,dcas,xx,dass,ifail)
      ifail=0
      das=dass

      return
      end
c---------------------------------------------------
      double precision function at(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cw(lck),lamw(lck),cr(lck),lamr(lck),
     & lamas(lck),lamat(lck),cas(lck),cat(lck),xx,att,
     & dlamw(lck),dcw(lck),dlamr(lck),dcr(lck),dlamas(lck),
     & dcas(lck),dlamat(lck),dcat(lck)

      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat 
 
      


      ifail=1
      call e02bbf(m1+4,lamat,cat,xx,att,ifail)
      ifail=0
      at=att

      return
      end
c---------------------------------------------------    
      double precision function dat(xx)
      implicit none
      integer m1,ifail,lck
      parameter (m1=401,lck=m1+4)
c      parameter (m1=1001,lck=m1+4)
      double precision cw(lck),lamw(lck),cr(lck),lamr(lck),
     & lamas(lck),lamat(lck),cas(lck),cat(lck),xx,datt,
     & dlamw(lck),dcw(lck),dlamr(lck),dcr(lck),dlamas(lck),
     & dcas(lck),dlamat(lck),dcat(lck)

      common/lambdasvm/lamw,dlamw,lamr,dlamr,lamas,dlamas,lamat,
     & dlamat,cw,dcw,cr,dcr,cas,dcas,cat,dcat 
 
      


      ifail=1
      call e02bbf(m1+4,dlamat,dcat,xx,datt,ifail)
      ifail=0
      dat=datt

      return
      end
c---------------------------------------------------  
