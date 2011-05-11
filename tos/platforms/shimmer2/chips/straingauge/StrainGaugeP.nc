/*
 * Copyright (c) 2011, Shimmer Research, Ltd.
 * All rights reserved
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:

 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 *     * Neither the name of Shimmer Research, Ltd. nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.

 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * @author  Steve Ayer
 * @date    February, 2011
 */

module StrainGaugeP {
  provides {
    interface Init;
    interface StrainGauge;
  }
}

implementation {
  /*
   * don't forget to power it up, not done here
   */
  command error_t Init.init(){

    // power, active low
    TOSH_MAKE_SER0_RTS_OUTPUT();
    TOSH_SEL_SER0_RTS_IOFUNC();

    // best to leave this off until it's actually in use
    call StrainGauge.powerOff();

   // this one tied to the led
    TOSH_MAKE_URXD0_OUTPUT();
    TOSH_SEL_URXD0_IOFUNC();
    call StrainGauge.ledOff();

    return SUCCESS;
  }

  command void StrainGauge.powerOn(){
    call StrainGauge.ledOn();
    TOSH_CLR_SER0_RTS_PIN();
  }

  command void StrainGauge.powerOff(){
    call StrainGauge.ledOff();
    TOSH_SET_SER0_RTS_PIN();
  }

  command void StrainGauge.ledOn() {
    TOSH_CLR_URXD0_PIN();
  }

  command void StrainGauge.ledOff() {
    TOSH_SET_URXD0_PIN();
  }

  command void StrainGauge.ledToggle() {
    TOSH_TOGGLE_URXD0_PIN();
  }
}




