# discrete-time-convolution
implementation of discrete time convolution in MATLAB

Asked to implement our own comnvolution function, without using built-in conv function. Then comparing outputs of two inputs , with the built in function. Printing in vector and 
plot styles. After these, we were asked to convolve our own voice with the given system.  Which works by determining h(n) unit-response function and then convolving it with our voice arrary.


𝑦[𝑛] = 𝑥[𝑛] + ∑ k= 1->M   A*K*𝑥[𝑛 − 400. 𝑘]

We also had to decide what the function was doing. I have correctly determined that this is an echo function and the echo increases as the M increases. Too high M results in corruption of sound .
