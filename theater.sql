--This database is a theater database that shows the understanding of entities, attributes, and relationships from the model. 
BEGIN;


CREATE TABLE IF NOT EXISTS public.accounts
(
    id integer NOT NULL DEFAULT nextval('accounts_id_seq'::regclass),
    password text COLLATE pg_catalog."default" NOT NULL,
    username text COLLATE pg_catalog."default" NOT NULL,
    customer_id integer NOT NULL,
    CONSTRAINT accounts_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.auditoria
(
    id integer NOT NULL DEFAULT nextval('auditoria_id_seq'::regclass),
    capacity integer NOT NULL,
    CONSTRAINT auditoria_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.customers
(
    id integer NOT NULL DEFAULT nextval('customers_id_seq'::regclass),
    name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT customers_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.event_purchases
(
    customer_id integer NOT NULL,
    event_id integer NOT NULL,
    price numeric NOT NULL,
    CONSTRAINT event_purchases_pkey PRIMARY KEY (customer_id, event_id)
);

CREATE TABLE IF NOT EXISTS public.events
(
    id integer NOT NULL DEFAULT nextval('events_id_seq'::regclass),
    show_time timestamp without time zone,
    auditorium_id integer,
    film_id integer NOT NULL,
    CONSTRAINT events_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.films
(
    id integer NOT NULL DEFAULT nextval('films_id_seq'::regclass),
    title text COLLATE pg_catalog."default" NOT NULL,
    runtime integer,
    CONSTRAINT films_pkey PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.accounts
    ADD CONSTRAINT fk_accounts_customers FOREIGN KEY (customer_id)
    REFERENCES public.customers (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
CREATE INDEX IF NOT EXISTS accounts_customer_id_key
    ON public.accounts(customer_id);


ALTER TABLE IF EXISTS public.event_purchases
    ADD CONSTRAINT fk_event_purchases_customers FOREIGN KEY (customer_id)
    REFERENCES public.customers (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.event_purchases
    ADD CONSTRAINT fk_event_purchases_events FOREIGN KEY (event_id)
    REFERENCES public.events (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.events
    ADD CONSTRAINT fk_events_auditoria FOREIGN KEY (auditorium_id)
    REFERENCES public.auditoria (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.events
    ADD CONSTRAINT fk_events_films FOREIGN KEY (film_id)
    REFERENCES public.films (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;