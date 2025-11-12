import { NgModule, Injector } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { createCustomElement } from '@angular/elements';
import { FirstComponentComponent } from './first-component/first-component.component';

@NgModule({
  declarations: [
    AppComponent,
    FirstComponentComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: []
})

// ✅ You must remove the normal bootstrap component.
//
// Your @NgModule decorator must NOT have:
//
// bootstrap: [AppComponent]
//
// Instead:
//
// bootstrap: []
//
// Or remove the entire bootstrap property.
//
// ✅ Why it goes here (quick explanation)
//
// Angular normally boots from a root component:
//
// <app-root></app-root>
//
// But when you're using custom elements, Angular does not use AppComponent as the main entry point.

export class AppModule {
    constructor(private injector: Injector) {}

  // ✅ Angular Elements setup goes here
  ngDoBootstrap() {
  // Angular needs the Injector to:
  // resolve component dependencies (services, DI tokens)
  // create the component instance when your custom element is inserted into the DOM
  // handle change detection correctly
    const el = createCustomElement(FirstComponentComponent, { injector: this.injector });
    customElements.define('first-component', el);
  }
 }

