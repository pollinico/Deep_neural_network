# Deep neural network
Example of the universal approximation theory of DNN

The universal approximation theorem states that a feed-forward deep network (with one or
more hidden layers) containing a finite number of neurons can approximate any continuous
functions compact subsets of R<sup>n</sup>. 

We will see an application of this property for a specific function. In this exercise we train the
network in order to approximate the following function: f(x<sub>1</sub>,x<sub>2</sub>)=x<sub>1</sub>exp(-x<sub>1</sub><sup>2</sup>-x<sub>2</sub><sup>2</sup>)  

![Function plot](fig1.jpg)  

We consider the following network architecture:
* Two inputs
* Four neurons in the first hidden layer
* Three neurons in the second hidden layer
* One linear output

![Neural network architecture](fig3.jpg)


![Trained approximation](fig2.jpg)  
