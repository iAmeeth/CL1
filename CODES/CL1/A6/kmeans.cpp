//============================================================================
// Name        : KMeans.cpp
// Author      : Manasi Godse
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include<stdlib.h>
#include<time.h>
#include<math.h>
using namespace std;

class kMeans{
	//for the dataset
	int noOfPoints;
	float *xCord;
	float *yCord;
	//for the random cluster centres
	float *centroidX;
	float *centroidY;
	//for holding the cluster numbers of points
	int *prevCluster;
	int *currentCluster;
	int noOfClusters;

public:
	kMeans(int noPoints,int noClusters)
	{
		noOfPoints=noPoints;
		xCord=new float(noOfPoints);
		yCord=new float(noOfPoints);
		noOfClusters=noClusters;
		centroidX=new float(noOfClusters);
		centroidY=new float(noOfClusters);
		prevCluster=new int(noOfPoints);
		currentCluster=new int(noOfPoints);

	}

	void acceptInput();
	void generateCentorids();
	void calculateDistance(int);
	void copyArray();
	void apriori();
	int checkArray();
	void generateMeanCentroids();
};

void kMeans::acceptInput()
{
	cout<<"Enter the  points ( x and y)"<<endl;
	cout<<noOfPoints;
	for(int i=0;i<noOfPoints;i++)
	{
		cin>>xCord[i]>>yCord[i];
	}

}
void kMeans::generateCentorids()
{
	int randIndex;
	cout<<"Centroids for Pass 1\n";
	for (int i=0;i<noOfClusters;i++)
		{
			randIndex=1+rand()%(noOfPoints-i-1);
			centroidX[i]=xCord[randIndex];
			centroidY[i]=yCord[randIndex];
			cout<<i<<") ("<<centroidX[i]<<","<<centroidY[i]<<")\n";
		}

}
void kMeans::generateMeanCentroids()
{
	float sumX[noOfPoints],sumY[noOfPoints];
	int count[noOfClusters];
	for(int i=0;i<noOfPoints;i++)
	{
		sumX[i]=0;
		sumY[i]=0;
	}
	for(int i=0;i<noOfClusters;i++)
	{
		count[i]=0;
	}

	for(int i=0;i<noOfClusters;i++)
	{
		for(int j=0;j<noOfPoints;j++)
		{
			if(currentCluster[j]==i)
			{
				count[i]=count[i]+1;
				sumX[i]=sumX[i]+xCord[j];
				sumY[i]=sumY[i]+yCord[j];
			}
		}
	}
	for(int i=0;i<noOfClusters;i++)
	{
		centroidX[i]=sumX[i]/count[i];
		centroidY[i]=sumY[i]/count[i];
		cout<<i<<") ("<<centroidX[i]<<","<<centroidY[i]<<")\n";
	}
}
void kMeans::calculateDistance(int point)
{
	float sum[noOfClusters];
	for(int i=0;i<noOfClusters;i++)
	{
		sum[i]=0;
	}
	float x1,x2;
	for(int i=0;i<noOfClusters;i++)
	{
		sum[i]=(fabs(centroidX[i]-xCord[point]))+(fabs(centroidY[i]-yCord[point]));
	}
	float min=sum[0];
	for(int i=1;i<noOfClusters;i++)
	{
		if(sum[i]<min)
		{
			min=sum[i];
		}
	}
	int index;
	for(int i=0;i<noOfClusters;i++)
		{
			if(sum[i]==min)
			{
				index=i;
			}
		}
	currentCluster[point]=index;

}

void kMeans::copyArray()
{
	for(int i=0;i<noOfPoints;i++)
	{
		prevCluster[i]=currentCluster[i];
	}
}
int kMeans::checkArray()
{
	for(int i=0;i<noOfPoints;i++)
	{
		if(prevCluster[i]!=currentCluster[i])
			return -1;

	}
	return 0;

}
void kMeans::apriori()
{

	int flag=0;
	int count=1;
	while(flag!=1)
	{

		if(count==1){
		generateCentorids();}
		else
		{
			cout<<"Centroids for Pass "<<count<<endl;
			generateMeanCentroids();
		}
		for(int i=0;i<noOfPoints;i++)
		{
			calculateDistance(i);
		}

		if(checkArray()==0){

			flag=1;}
		copyArray();
		count=count+1;

	}
	cout<<"==================================\n";
	cout<<"POINT \t\t CLUSTER NUMBER\n";
	cout<<"==================================\n";
	for(int i=0;i<noOfPoints;i++)
	{
		cout<<"Point "<<i<<" ("<<xCord[i]<<","<<yCord[i]<<")\t\t"<<currentCluster[i]<<endl;
	}
}

int main() {
	int noPoints,noClusters;
	cout<<"Enter number of points";
	cin>>noPoints;
	cout<<"Enter number of clusters";
	cin>>noClusters;
	kMeans kmeans(noPoints,noClusters);
	kmeans.acceptInput();
	kmeans.apriori();
	return 0;
}

