/***************************************************************
*
* Name: ThreatDatabase.h
*
* Description: Header file for the ThreatDatabase class.
*
* Author: Carlos Lazo & Nate Soule
*
***************************************************************/

#pragma once

#include <iostream>
#include <vector>
#include "Semaphore.h"
#include "Threat.h"

using namespace std;

class ThreatDatabase
{

private:

  // Declare private member variables.
  Semaphore semaphore;

  vector <Threat*> knownThreats;

public:

  // Constructor definition.
  
  ThreatDatabase();

  // Declare member functions.

  void AddThreat(Threat*);
  Threat* FindThreatByWF(long[]);
  Threat* FindThreatByID(long);
  long dbSize();
};

